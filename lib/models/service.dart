class Service {
  final String id;
  final String imageUrl;
  final String title;
  final String provider;
  final double rating;
  final int price;
  final String description;
  final String category;

  const Service({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.provider,
    required this.rating,
    required this.price,
    required this.description,
    required this.category,
  });

  static List<Service> get mockServices => [
        const Service(
          id: '1',
          title: 'Deep House Cleaning',
          provider: 'Sparkle Clean Co.',
          imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800',
          rating: 4.8,
          price: 45,
          category: 'Cleaning',
          description: 'Thorough cleaning of every corner of your home, including hard-to-reach areas and disinfection.',
        ),
        const Service(
          id: '2',
          title: 'Professional Massage',
          provider: 'Zen Wellness',
          imageUrl: 'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?w=800',
          rating: 4.9,
          price: 80,
          category: 'Wellness',
          description: 'Relaxing Swedish massage to relieve stress and muscle tension in the comfort of your home.',
        ),
        const Service(
          id: '3',
          title: 'Garden Maintenance',
          provider: 'Green Thumb',
          imageUrl: 'https://images.unsplash.com/photo-1592419044706-39796d40f98c?w=800',
          rating: 4.7,
          price: 35,
          category: 'Home',
          description: 'Lawn mowing, hedge trimming, and seasonal garden care provided by experienced professionals.',
        ),
        const Service(
          id: '4',
          title: 'Car Detailing',
          provider: 'AutoShine',
          imageUrl: 'https://images.unsplash.com/photo-1552933529-e359b2477262?w=800',
          rating: 4.6,
          price: 60,
          category: 'Auto',
          description: 'Premium interior and exterior car detailing to make your vehicle look brand new.',
        ),
        const Service(
          id: '5',
          title: 'Personal Training',
          provider: 'Flex Fitness',
          imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
          rating: 4.9,
          price: 55,
          category: 'Wellness',
          description: 'One-on-one fitness coaching tailored to your goals, whether it is weight loss, muscle gain, or endurance.',
        ),
        const Service(
          id: '6',
          title: 'Pet Grooming',
          provider: 'Paws & Claws',
          imageUrl: 'https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=800',
          rating: 4.7,
          price: 40,
          category: 'Pets',
          description: 'Professional grooming for your furry friends, including baths, haircuts, and nail trimming.',
        ),
        const Service(
          id: '7',
          title: 'PC Repair & Support',
          provider: 'Tech Geeks',
          imageUrl: 'https://images.unsplash.com/photo-1597733336794-12d05021d510?w=800',
          rating: 4.5,
          price: 70,
          category: 'Tech',
          description: 'Expert diagnostic and repair services for laptops and desktops. Hardware and software support provided.',
        ),
        const Service(
          id: '8',
          title: 'Graphic Design',
          provider: 'Creative Studio',
          imageUrl: 'https://images.unsplash.com/photo-1558655146-d09347e92766?w=800',
          rating: 4.8,
          price: 65,
          category: 'Creative',
          description: 'Logo design, social media graphics, and branding services to make your business stand out.',
        ),
        const Service(
          id: '9',
          title: 'Plumbing Services',
          provider: 'QuickFix Plumbers',
          imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800',
          rating: 4.4,
          price: 50,
          category: 'Home',
          description: 'Reliable plumbing repairs, installations, and emergency leak fixes available 24/7.',
        ),
        const Service(
          id: '10',
          title: 'Photography',
          provider: 'Lens Magic',
          imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800',
          rating: 4.9,
          price: 90,
          category: 'Creative',
          description: 'Professional event photography, portraits, and product shoots with high-quality editing.',
        ),
      ];
}
