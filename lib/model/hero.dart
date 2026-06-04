// Model untuk data dari SuperHero API
// Dibuat dari JSON response: superheroapi.com/api.php/{token}/search/batman
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

HeroData heroDataFromJson(String str) => HeroData.fromJson(json.decode(str));
String heroDataToJson(HeroData data) => json.encode(data.toJson());

class HeroData {
  String? response;
  String? resultsFor;
  List<Result>? results;

  HeroData({
    this.response,
    this.resultsFor,
    this.results,
  });

  factory HeroData.fromJson(Map<String, dynamic> json) => HeroData(
        response: json["response"],
        resultsFor: json["results-for"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "results-for": resultsFor,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  String? id;
  String? name;
  Powerstats? powerstats;
  Biography? biography;
  Appearance? appearance;
  Work? work;
  Connections? connections;
  // img menggantikan image agar tidak conflict dengan class Image dari Flutter
  String? img;

  Result({
    this.id,
    this.name,
    this.powerstats,
    this.biography,
    this.appearance,
    this.work,
    this.connections,
    this.img,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        powerstats: json["powerstats"] == null
            ? null
            : Powerstats.fromJson(json["powerstats"]),
        biography: json["biography"] == null
            ? null
            : Biography.fromJson(json["biography"]),
        appearance: json["appearance"] == null
            ? null
            : Appearance.fromJson(json["appearance"]),
        work: json["work"] == null ? null : Work.fromJson(json["work"]),
        connections: json["connections"] == null
            ? null
            : Connections.fromJson(json["connections"]),
        // Ambil URL gambar dari nested object "image"
        img: json["image"] == null ? null : json["image"]["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "powerstats": powerstats?.toJson(),
        "biography": biography?.toJson(),
        "appearance": appearance?.toJson(),
        "work": work?.toJson(),
        "connections": connections?.toJson(),
        "image": {"url": img},
      };
}

class Powerstats {
  String? intelligence;
  String? strength;
  String? speed;
  String? durability;
  String? power;
  String? combat;

  Powerstats({
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) => Powerstats(
        intelligence: json["intelligence"],
        strength: json["strength"],
        speed: json["speed"],
        durability: json["durability"],
        power: json["power"],
        combat: json["combat"],
      );

  Map<String, dynamic> toJson() => {
        "intelligence": intelligence,
        "strength": strength,
        "speed": speed,
        "durability": durability,
        "power": power,
        "combat": combat,
      };
}

class Biography {
  String? fullName;
  String? alterEgos;
  List<String>? aliases;
  String? placeOfBirth;
  String? firstAppearance;
  String? publisher;
  String? alignment;

  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) => Biography(
        fullName: json["full-name"],
        alterEgos: json["alter-egos"],
        aliases: json["aliases"] == null
            ? []
            : List<String>.from(json["aliases"]!.map((x) => x)),
        placeOfBirth: json["place-of-birth"],
        firstAppearance: json["first-appearance"],
        publisher: json["publisher"],
        alignment: json["alignment"],
      );

  Map<String, dynamic> toJson() => {
        "full-name": fullName,
        "alter-egos": alterEgos,
        "aliases": aliases == null
            ? []
            : List<dynamic>.from(aliases!.map((x) => x)),
        "place-of-birth": placeOfBirth,
        "first-appearance": firstAppearance,
        "publisher": publisher,
        "alignment": alignment,
      };
}

class Appearance {
  String? gender;
  String? race;
  List<String>? height;
  List<String>? weight;
  String? eyeColor;
  String? hairColor;

  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) => Appearance(
        gender: json["gender"],
        race: json["race"],
        height: json["height"] == null
            ? []
            : List<String>.from(json["height"]!.map((x) => x)),
        weight: json["weight"] == null
            ? []
            : List<String>.from(json["weight"]!.map((x) => x)),
        eyeColor: json["eye-color"],
        hairColor: json["hair-color"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "race": race,
        "height":
            height == null ? [] : List<dynamic>.from(height!.map((x) => x)),
        "weight":
            weight == null ? [] : List<dynamic>.from(weight!.map((x) => x)),
        "eye-color": eyeColor,
        "hair-color": hairColor,
      };
}

class Work {
  String? occupation;
  String? base;

  Work({this.occupation, this.base});

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        occupation: json["occupation"],
        base: json["base"],
      );

  Map<String, dynamic> toJson() => {
        "occupation": occupation,
        "base": base,
      };
}

class Connections {
  String? groupAffiliation;
  String? relatives;

  Connections({this.groupAffiliation, this.relatives});

  factory Connections.fromJson(Map<String, dynamic> json) => Connections(
        groupAffiliation: json["group-affiliation"],
        relatives: json["relatives"],
      );

  Map<String, dynamic> toJson() => {
        "group-affiliation": groupAffiliation,
        "relatives": relatives,
      };
}

/* class Image sudah di-comment karena img langsung diambil di class Result
class ImageHero {
  ImageHero({this.url});
  String? url;

  factory ImageHero.fromJson(Map<String, dynamic> json) => ImageHero(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
*/
