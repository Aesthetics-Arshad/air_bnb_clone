class Listing {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final int pricePerNightInr;
  final double rating;
  final String description;

  const Listing({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.pricePerNightInr,
    required this.rating,
    required this.description,
  });
}

// ✅ Fixed URLs with reliable Unsplash links (all Indian destinations)
const listings = <Listing>[
  Listing(
    id: 'goa-beach',
    title: 'Sea Breeze Studio, Goa',
    location: 'Candolim, Goa',
    imageUrl:
        'https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    pricePerNightInr: 3999,
    rating: 4.7,
    description:
        'Sunlit studio a short walk to Candolim beach. Balcony + kitchenette. Perfect for weekend getaways.',
  ),
  Listing(
    id: 'jaipur-haveli',
    title: 'Heritage Haveli Suite',
    location: 'Jaipur, Rajasthan',
    imageUrl:
        'https://images.unsplash.com/photo-1544989164-31dc3c645987?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    pricePerNightInr: 2990,
    rating: 4.6,
    description:
        'Royal suite in a restored haveli near Hawa Mahal. Courtyard breakfasts and pink city views.',
  ),
  Listing(
    id: 'manali-chalet',
    title: 'Cedarwood Chalet',
    location: 'Manali, Himachal',
    imageUrl:
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    pricePerNightInr: 4490,
    rating: 4.8,
    description:
        'Warm wooden chalet with mountain views, bonfire pit and fast Wi-Fi. Great for workcations.',
  ),
  Listing(
    id: 'mumbai-bay',
    title: 'Bay View Apartment',
    location: 'Marine Drive, Mumbai',
    imageUrl:
        'https://images.unsplash.com/photo-1548013146-72479768bada?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    pricePerNightInr: 5490,
    rating: 4.5,
    description:
        '11th-floor apartment overlooking the Queen’s Necklace. Sunrise coffees on the balcony.',
  ),
  Listing(
    id: 'varanasi-ghats',
    title: 'Ghatside Retreat',
    location: 'Varanasi, Uttar Pradesh',
    imageUrl:
            'https://images.unsplash.com/photo-1624367273422-1a89f4804040?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
    pricePerNightInr: 2590,
    rating: 4.4,
    description:
        'Calm room near Dashashwamedh Ghat. Evening aarti at your doorstep, wholesome breakfasts.',
  ),
  Listing(
    id: 'munnar-tea',
    title: 'Tea Garden Cottage',
    location: 'Munnar, Kerala',
    imageUrl:
          'https://images.unsplash.com/photo-1620656855960-9f409775888b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
    pricePerNightInr: 3290,
    rating: 4.7,
    description:
        'Cozy cottage in rolling tea estates. Misty mornings, nature trails and homemade meals.',
  ),
  Listing(
    id: 'udaipur-lake',
    title: 'Lakefront Nook',
    location: 'Udaipur, Rajasthan',
    imageUrl:
        'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80',
    pricePerNightInr: 3890,
    rating: 4.6,
    description:
        'Charming room by Lake Pichola. Rooftop dinners with palace views.',
  ),
  Listing(
    id: 'hampi-heritage',
    title: 'Stone & Sky Homestay',
    location: 'Hampi, Karnataka',
    imageUrl:
         'https://images.unsplash.com/photo-1601121140727-0efbe2a7afc3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
    pricePerNightInr: 2390,
    rating: 4.5,
    description:
        'Rustic stay amidst boulders and rice fields. Guided ruins tours available on request.',
  ),
];
