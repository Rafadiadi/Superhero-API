import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'createmoods_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperHero Mood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Halaman awal aplikasi
      home: const MainScreen(),
      // Named routes untuk navigasi antar halaman
      routes: {
        CreateMoodsScreen.id: (context) => const CreateMoodsScreen(),
      },
    );
  }
}
