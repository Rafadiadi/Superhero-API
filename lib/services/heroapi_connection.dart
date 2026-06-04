import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/hero.dart';

class HeroApiConnection {
  String? heroName;

  HeroApiConnection({this.heroName});

  Future<HeroData> getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://www.superheroapi.com/api.php/b5b8bf84f8a5b69028cefed24db018b6/search/$heroName',
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      HeroData heroData = HeroData.fromJson(json);
      return heroData;
    } else {
      throw Exception('Failed to load HeroData');
    }
  }
}
