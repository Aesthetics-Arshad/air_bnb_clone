import 'package:flutter/material.dart';
import '../app_state.dart';
import '../data/listings.dart';

class ListingDetailPage extends StatelessWidget {
  final Listing listing;
  const ListingDetailPage({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.title)),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16/10,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(listing.location,
                    style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 18),
                    const SizedBox(width: 4),
                    Text(listing.rating.toStringAsFixed(1)),
                    const Spacer(),
                    Text('₹${listing.pricePerNightInr} night',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(listing.description),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<Set<String>>(
                      valueListenable: AppState.wishlistIds,
                      builder: (_, ids, __) {
                        final saved = ids.contains(listing.id);
                        return OutlinedButton.icon(
                          onPressed: () => AppState.toggleWishlist(listing.id),
                          icon: Icon(saved ? Icons.check : Icons.favorite_border),
                          label: Text(saved ? 'Saved' : 'Wishlist'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        AppState.addMessage(
                          Message(
                            listingId: listing.id,
                            listingTitle: listing.title,
                            text: 'Hi! Is ${listing.title} available next weekend?',
                            timestamp: DateTime.now(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent to host (demo).')),
                        );
                      },
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Message host'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking flow not implemented yet.')),
                        );
                      },
                      child: const Text('Book'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
