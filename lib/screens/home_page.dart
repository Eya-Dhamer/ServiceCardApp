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
        title: const Text("Explore Services"),
      ),
      drawer: const DrawerMenu(),
      body: const HomeContent(),
    );
  }
}
