import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/hero.dart';

class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';

  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  // Controller untuk TextField moods
  final TextEditingController _moodsController = TextEditingController();

  // getData() sekarang mengembalikan Future<HeroData>
  // agar bisa digunakan oleh FutureBuilder
  Future<HeroData> getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://www.superheroapi.com/api.php/b5b8bf84f8a5b69028cefed24db018b6/search/batman',
      ),
    );

    // Periksa status code dari response API
    if (response.statusCode == 200) {
      // Jika berhasil (kode 200), decode JSON dan return objek HeroData
      return HeroData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load HeroData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FutureBuilder: widget yang dapat menggenerate widget lainnya
      // berdasarkan data Future yang diambil dari API
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<HeroData> snapshot) {
          // Cek apakah snapshot sudah berisi data
          if (snapshot.hasData) {
            // Jika data sudah ada, tampilkan ListView
            return ListView.builder(
              // itemCount: banyaknya item sesuai panjang data results API
              itemCount: snapshot.data?.results?.length,
              itemBuilder: ((context, index) {
                // heroesData: menyimpan data hero sesuai index
                var heroesData = snapshot.data!.results![index];

                return Column(
                  children: [
                    InkWell(
                      onTap: null, // akan diisi navigasi di bagian berikutnya
                      child: Card(
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: 20.0),
                          height: 300.0,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Tampilkan gambar hero dari URL (field img)
                              Image.network(heroesData.img ?? ''),
                              // Tampilkan nama hero
                              Text(
                                heroesData.name ?? '',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
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
            // Jika data belum ada, tampilkan loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      // BottomSheet untuk input moods
      bottomSheet: Card(
        child: ListTile(
          leading: const Text(
            'Moods',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          title: TextField(
            controller: _moodsController,
            decoration: const InputDecoration(
              hintText: 'Tulis mood kamu...',
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Kembali ke halaman sebelumnya (main_screen)
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
