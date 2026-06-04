import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'createmoods_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String myDisplayName = 'User';
  String imgProfile =
      'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
  String namaHero = 'superheroname';
  String moodsHero = '.....';

  final _firebaseFirestore = FirebaseFirestore.instance.collection('moods');

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    streamFirestoreData();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        myDisplayName = user.displayName ?? 'User';
      }
    } catch (e) {
      print(e);
    }
  }

  void streamFirestoreData() {
    if (loggedInUser != null && loggedInUser!.email != null) {
      _firebaseFirestore
          .doc(loggedInUser!.email)
          .snapshots()
          .listen((event) {
        if (event.data() != null) {
          setState(() {
            namaHero = event.data()!['namahero'] ?? namaHero;
            imgProfile = event.data()!['urlhero'] ?? imgProfile;
            moodsHero = event.data()!['moodstext'] ?? moodsHero;
          });
        }
      });
    }
  }

  void deleteMoods() async {
    if (loggedInUser != null && loggedInUser!.email != null) {
      await _firebaseFirestore.doc(loggedInUser!.email).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imgProfile),
                    radius: 80.0,
                  ),
                  Text(
                    'Helo $myDisplayName, you are $namaHero!',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Moods: $moodsHero',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteMoods();
                      setState(() {
                        imgProfile =
                            'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
                        namaHero = 'superheroname';
                        moodsHero = '.....';
                      });
                    },
                    child: const Text('Delete moods'),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const IconButton(
                          iconSize: 35.0,
                          tooltip: 'Set Profile Name',
                          icon: Icon(Icons.settings),
                          onPressed: null,
                        ),
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Create Moods',
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.pushNamed(context, CreateMoodsScreen.id)
                                .whenComplete(() => streamFirestoreData());
                          },
                        ),
                        const IconButton(
                          iconSize: 35.0,
                          tooltip: 'Log Out',
                          icon: Icon(Icons.power_settings_new),
                          onPressed: null,
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
