import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateMoodsScreen extends StatefulWidget {
  // ID statis untuk navigasi menggunakan named routes
  static const String id = 'createmoods_screen';

  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  // Method getData() untuk mengambil data dari SuperHero API
  // async karena http.get bekerja secara asynchronous
  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://www.superheroapi.com/api.php/b5b8bf84f8a5b69028cefed24db018b6/search/batman',
      ),
    );
    // Tampilkan isi response dari API di console (Debug Console)
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // Panggil getData() setiap kali halaman ini dibuat
    getData();
    return Container();
  }
}
