import 'package:flutter/material.dart';
import '../app_state.dart';
import '../data/listings.dart';
import '../pages/listing_detail_page.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  const ListingCard({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListingDetailPage(listing: listing),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      listing.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: ValueListenableBuilder<Set<String>>(
                      valueListenable: AppState.wishlistIds,
                      builder: (_, ids, __) {
                        final saved = ids.contains(listing.id);
                        return InkWell(
                          onTap: () => AppState.toggleWishlist(listing.id),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              saved ? Icons.favorite : Icons.favorite_border,
                              color: saved ? Colors.red : Colors.black54,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listing.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(height: 2),
                        Text(listing.location,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(
                          '₹${listing.pricePerNightInr.toString()} night',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16),
                      const SizedBox(width: 4),
                      Text(listing.rating.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
