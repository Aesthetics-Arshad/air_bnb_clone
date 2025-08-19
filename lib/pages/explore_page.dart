import 'package:flutter/material.dart';

import '../data/listings.dart';
import '../widgets/listing_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // 🔍 Filter listings based on search
    final filteredListings = listings.where((listing) {
      final title = listing.title.toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Start your search",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 📍 Location Chip
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Maps will be implemented in future"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Chip(
                label: const Text(
                  "Homes in Lucknow",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
                avatar: const Icon(Icons.location_on, color: Colors.red),
              ),
            ),

            // 🏠 Listings (scrollable, filtered)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
                ),
                child: filteredListings.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredListings.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, i) =>
                            ListingCard(listing: filteredListings[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


}


