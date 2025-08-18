import 'package:flutter/foundation.dart';

class AppState {
  // Fake auth flags (no Firebase yet)
  static bool hasAccount = false;
  static bool isLoggedIn = false;

  // Wishlist as set of listing IDs
  static final ValueNotifier<Set<String>> wishlistIds =
      ValueNotifier<Set<String>>(<String>{});

  // Minimal inbox model
  static final ValueNotifier<List<Message>> messages =
      ValueNotifier<List<Message>>(<Message>[]);

  static void toggleWishlist(String id) {
    final s = Set<String>.from(wishlistIds.value);
    if (s.contains(id)) {
      s.remove(id);
    } else {
      s.add(id);
    }
    wishlistIds.value = s;
  }

  static void addMessage(Message m) {
    final list = List<Message>.from(messages.value)..add(m);
    messages.value = list;
  }

  static void logout() {
    isLoggedIn = false;
  }
}

class Message {
  final String listingId;
  final String listingTitle;
  final String text;
  final DateTime timestamp;

  Message({
    required this.listingId,
    required this.listingTitle,
    required this.text,
    required this.timestamp,
  });
}
