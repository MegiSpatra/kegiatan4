import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thumbnailer/thumbnailer.dart';

class Game {
  int id;
  String title;
  String thumbnail;
  String short_description;
  String game_url;
  String genre;
  String platform;
  String publisher;
  String developer;
  String release_date;
  String freetogame_profile_url;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.short_description,
    required this.game_url,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.release_date,
    required this.freetogame_profile_url,
  });

// fungsi factory untuk mengambil data json tiap product
  factory Game.fromJson(Map<String, dynamic> map) {
    return Game(
      id: map["id"],
      title: map["title"],
      thumbnail: map["thumbnail"],
      short_description: map["short_description"].toString(),
      game_url: map["game_url"],
      genre: map["genre"],
      platform: map["platform"],
      publisher: map["publisher"],
      developer: map["developer"],
      release_date: map["release_date"],
      freetogame_profile_url: map["freetogame_profile_url"],
    );
  }
  static Future<List<Game>> connectToApi() async {
    String apiUrl = "https://www.freetogame.com/api/games";
    List<Game> product = [];
// mendapatkan result data setelah koenksi get metohod
    var apiResult = await http.get(Uri.parse(apiUrl));
// mendecode hasi dari method get
    var jsonObject = json.decode(apiResult.body);
// menambahkan data ke list product
    for (var i = 0; i < jsonObject.length; i++) {
      product.add(Game.fromJson(jsonObject[i]));
    }
// mengembalikan listProdut
    return product;
  }
}
