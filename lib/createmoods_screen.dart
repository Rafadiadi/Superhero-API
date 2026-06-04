import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/heroapi_connection.dart';
import 'model/hero.dart';

class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';

  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  String? heroNameToSearch;
  Future<HeroData>? getHeroData;
  String? namaHero;
  String? imgHero;
  int selectedIndex = -1;
  String? moodsText;
  
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search your hero first',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
                onChanged: (value) {
                  heroNameToSearch = value;
                  setState(() {
                    getHeroData = HeroApiConnection(heroName: heroNameToSearch)
                        .getData();
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<HeroData>(
                future: getHeroData,
                builder: (context, snapshot) {
                  if (heroNameToSearch == null || heroNameToSearch!.isEmpty) {
                    return const Center(child: Text('Search your hero first'));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  
                  if (snapshot.hasData) {
                    if (snapshot.data?.response == 'error') {
                      return const Center(child: Text('Hero tidak ditemukan'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.results?.length ?? 0,
                      itemBuilder: ((context, index) {
                        var heroesData = snapshot.data!.results![index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  selectedIndex = index;
                                  namaHero = heroesData.name;
                                  imgHero = heroesData.img;
                                });
                              },
                              child: Card(
                                shape: (selectedIndex == index)
                                    ? const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.blueAccent))
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  height: 300.0,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      if (heroesData.img != null)
                                        Image.network(
                                          heroesData.img!,
                                          width: 150,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      Expanded(
                                        child: Text(
                                          heroesData.name ?? '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Card(
        child: ListTile(
          leading: const Text(
            'Moods',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          title: TextField(
            onChanged: (value) {
              moodsText = value;
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              var loggedInUser = FirebaseAuth.instance.currentUser;
              if (loggedInUser != null && loggedInUser.email != null) {
                await firestoreInstance
                    .collection('moods')
                    .doc(loggedInUser.email)
                    .set({
                  'namahero': '$namaHero',
                  'urlhero': '$imgHero',
                  'moodstext': '$moodsText'
                }).then((value) {
                  print('${loggedInUser.displayName} berhasil menambahkan moods');
                }).catchError((error) {
                  print('Gagal menambahkan moods ke database');
                });
              } else {
                // Sesuai kodingan tutorial jika belum login, docID akan error, 
                // tapi kita tambahkan check null safety karena Flutter 3+
                print('Login diperlukan untuk menyimpan ke Firestore');
              }
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
