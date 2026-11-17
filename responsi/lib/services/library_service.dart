import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/games.dart';

class LibraryService {
  static const String _libraryBoxName = 'libraryBox';
  static const String _libraryKey = 'library';

  static Future<void> addToLibrary(games game) async {
    final box = await Hive.openBox(_libraryBoxName);
    List<Map<String, dynamic>> libraryList =
        List<Map<String, dynamic>>.from(box.get(_libraryKey, defaultValue: []));
    libraryList.add(game.toMap());
    await box.put(_libraryKey, libraryList);
  }

  static Future<void> removeFromLibrary(int gameId) async {
    final box = await Hive.openBox(_libraryBoxName);
    List<Map<String, dynamic>> libraryList =
        List<Map<String, dynamic>>.from(box.get(_libraryKey, defaultValue: []));
    libraryList.removeWhere((game) => game['id'] == gameId);
    await box.put(_libraryKey, libraryList);
  }

  static Future<List<games>> getLibrary() async {
    final box = await Hive.openBox(_libraryBoxName);
    List<Map<String, dynamic>> libraryList =
        List<Map<String, dynamic>>.from(box.get(_libraryKey, defaultValue: []));
    return libraryList.map((gameMap) => games.fromJson(gameMap)).toList();
  }
}