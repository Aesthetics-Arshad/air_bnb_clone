import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../data/listings.dart';
import '../widgets/listing_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
    });
  }

  Set<Marker> _buildMarkers() {
    return listings.map((listing) {
      return Marker(
        markerId: MarkerId(listing.id),
        position: LatLng(
          _currentPosition?.latitude ?? 26.8467, // fallback: Lucknow
          _currentPosition?.longitude ?? 80.9462,
        ),
        infoWindow: InfoWindow(
          title: listing.title,
          snippet: "₹${listing.pricePerNightInr}/night",
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Google Map
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 12,
                  ),
                  markers: _buildMarkers(),
                  onMapCreated: (controller) => _mapController = controller,
                  myLocationEnabled: true,
                ),

          /// 🔹 Search Bar + Location Chip
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
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
                GestureDetector(
                  onTap: () {
                    _mapController?.animateCamera(
                      CameraUpdate.newLatLng(_currentPosition ??
                          const LatLng(26.8467, 80.9462)),
                    );
                  },
                  child: Chip(
                    label: Text(
                      "Homes in Lucknow",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.white,
                    avatar: const Icon(Icons.location_on, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Sliding Panel for Listings
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
                ),
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: listings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      ListingCard(listing: listings[i]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

