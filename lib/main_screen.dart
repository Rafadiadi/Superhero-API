import 'package:flutter/material.dart';
import 'createmoods_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // URL profil default user (akan diganti dengan data dari Firebase nantinya)
  String imgProfile =
      'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';

  // Nama tampilan user (akan diambil dari Firebase nantinya)
  dynamic myDisplayName = 'User';

  @override
  Widget build(BuildContext context) {
    // PopScope menonaktifkan tombol back system Android untuk mengurangi bug
    // (PopScope menggantikan WillPopScope yang sudah deprecated di Flutter 3.12+)
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                children: [
                  // Foto profil berbentuk lingkaran menggunakan NetworkImage
                  CircleAvatar(
                    backgroundImage: NetworkImage(imgProfile),
                    radius: 80.0,
                  ),

                  // Teks sapaan user beserta nama superhero-nya
                  Text(
                    'Helo $myDisplayName, you are Superheroname!',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Jarak antara teks pertama dan kedua
                  const SizedBox(height: 20.0),

                  // Teks moods yang nantinya diambil dari Firebase
                  const Text(
                    'Moods: ........',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Expanded memastikan Row tombol mengisi sisa ruang dan berada di bawah layar
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Tombol Settings - navigasi ke halaman pengaturan profil
                        const IconButton(
                          iconSize: 35.0,
                          tooltip: 'Set Profile Name',
                          icon: Icon(Icons.settings),
                          onPressed: null, // akan diisi navigasi di bagian berikutnya
                        ),
                        // Tombol Add Moods - navigasi ke halaman CreateMoodsScreen
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Create Moods',
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.pushNamed(context, CreateMoodsScreen.id);
                          },
                        ),
                        // Tombol Log Out - akan diimplementasikan dengan Firebase Auth
                        const IconButton(
                          iconSize: 35.0,
                          tooltip: 'Log Out',
                          icon: Icon(Icons.power_settings_new),
                          onPressed: null, // akan diisi fungsi logout di bagian berikutnya
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
