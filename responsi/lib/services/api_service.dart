import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';
import '../models/game_detail_model.dart';

class ApiService {
  static const String gamesUrl = 'https://www.freetogame.com/api/games';
  static const String gameDetailUrl = 'https://www.freetogame.com/api/game';

  static Future<List<Game>> fetchGames() async {
    try {
      final response = await http.get(Uri.parse(gamesUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Game.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat daftar game (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Gagal memuat game: $e');
    }
  }

  static Future<GameDetail> fetchGameDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$gameDetailUrl?id=$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return GameDetail.fromJson(jsonData);
      } else {
        throw Exception('Gagal memuat detail game (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Gagal memuat detail game: $e');
    }
  }
}
