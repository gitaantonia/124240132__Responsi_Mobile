import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/games.dart';

class ApiService {
  static const String baseUrl = 'https://www.freetogame.com/api/games';

  static Future<List<games>> fetchGames() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => games.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }

  static Future<games> fetchGameDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl?id=$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return games.fromJson(jsonData);
    } else {
      throw Exception('Failed to load game details');
    }
  }
}