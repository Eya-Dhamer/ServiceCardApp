import 'package:flutter/material.dart';
import 'package:app_7/widgets/home_content.dart';
import 'package:app_7/widgets/drawer_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Benefit Services",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const DrawerMenu(),
      body: const HomeContent(),
    );
  }
}
