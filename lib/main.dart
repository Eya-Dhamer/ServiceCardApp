import 'package:app_7/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_7/approuter.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', 
       routes: appRoutes(),  // Utilisation des routes depuis le fichier séparé 
    );
  }
}
