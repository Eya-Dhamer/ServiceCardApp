import 'package:flutter/material.dart';

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Profile', icon: Icons.person),
  Choice(title: 'Subscribe', icon: Icons.directions),
  Choice(title: 'Settings', icon: Icons.settings),
  Choice(title: 'Exit', icon: Icons.exit_to_app),
];
