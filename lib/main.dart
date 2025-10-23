import 'package:flutter/material.dart';
//import 'atelier1.dart';
import 'atelier2.dart'; // Décommentez pour tester l'atelier 2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material 3',
      theme: ThemeData(useMaterial3: true),
      //home: const ProfilePageM3(), // Pour tester l'atelier 1
       home: const ProductListPageM3(), // Décommentez pour tester l'atelier 2
    );
  }
}
