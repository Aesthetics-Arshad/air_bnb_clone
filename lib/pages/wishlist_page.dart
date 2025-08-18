import 'package:flutter/material.dart';
import '../app_state.dart';
import '../data/listings.dart';
import '../widgets/listing_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final map = {for (final l in listings) l.id: l};

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlists')),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: AppState.wishlistIds,
        builder: (_, ids, __) {
          if (ids.isEmpty) {
            return const Center(child: Text('No saved stays yet.'));
          }
          final items = ids.map((id) => map[id]).whereType().toList();
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => ListingCard(listing: items[i]),
          );
        },
      ),
    );
  }
}
