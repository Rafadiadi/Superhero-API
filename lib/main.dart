import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main_screen.dart';
import 'createmoods_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Catatan: Pastikan google-services.json sudah ada di folder android/app/
  // sebelum menjalankan aplikasi, jika tidak aplikasi akan crash.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization error: $e");
  }
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
