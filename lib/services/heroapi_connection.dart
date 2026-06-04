import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/hero.dart';

class HeroApiConnection {
  String? heroName;

  HeroApiConnection({this.heroName});

  Future<HeroData> getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json',
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      
      String search = heroName?.toLowerCase() ?? '';
      List<dynamic> filtered = jsonList.where((hero) {
        String name = hero['name']?.toString().toLowerCase() ?? '';
        return name.contains(search);
      }).toList();

      if (filtered.isEmpty) {
        return HeroData(response: 'error', results: []);
      }

      return HeroData(
        response: 'success',
        resultsFor: search,
        results: filtered.map((x) => Result.fromJsonAkabab(x)).toList(),
      );
    } else {
      throw Exception('Failed to load HeroData from akabab');
    }
  }
}
