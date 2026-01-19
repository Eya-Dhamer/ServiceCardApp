import 'package:flutter/material.dart';
import 'package:app_7/models/service.dart';
import 'service_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  // Liste de services
  final List<Service> services = const [
    Service(
      imageUrl: "https://randomuser.me/api/portraits/women/68.jpg",
      title: "Personal Care",
      provider: "Hela Ben Youssef",
      rating: 4.5,
      price: 25,
    ),
    Service(
      imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      title: "Painter",
      provider: "Amin Ben Salah",
      rating: 4.5,
      price: 20,
    ),
    Service(
      imageUrl: "https://randomuser.me/api/portraits/men/75.jpg",
      title: "Electrical",
      provider: "Samir Haddad",
      rating: 4.5,
      price: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Which service do you need?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const Text(
              "Popular Services",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Affichage des services avec map
            // On transforme chaque élément de la liste en widget, puis on les ajoutes avec l’opérateur ....
            ...services.map(
              (service) => Column(
                children: [
                  ServiceCard(service: service),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
