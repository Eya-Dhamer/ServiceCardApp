// Importation des packages nécessaires 
 
import 'package:app_7/screens/home_page.dart'; 
import 'package:app_7/screens/subscribe.dart'; 
import 'package:flutter/material.dart'; 
 
// Définition d'une fonction qui retourne les routes 
Map<String, WidgetBuilder> appRoutes() { 
  return { 
    '/home': (context) => const HomePage(), 
   
    '/Subscribe': (context) => const Subscribe(), 
  }; 
} 