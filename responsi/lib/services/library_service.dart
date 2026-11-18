import 'package:hive/hive.dart';
import '../models/game_model.dart';

class LibraryService {
  static const String _libraryBoxName = 'libraryBox';
  static const String _libraryKey = 'library_items';

  static Future<Box> _getBox() async {
    if (!Hive.isBoxOpen(_libraryBoxName)) {
      return await Hive.openBox(_libraryBoxName);
    }
    return Hive.box(_libraryBoxName);
  }

  static Future<List<Game>> getLibrary() async {
    final box = await _getBox();
    final rawList = box.get(_libraryKey, defaultValue: []);
    if (rawList is List) {
      return rawList.map((item) {
        if (item is Map) {
          return Game.fromMap(Map<String, dynamic>.from(item));
        }
        return Game.fromMap({});
      }).toList();
    }
    return [];
  }

  static Future<bool> isInLibrary(int gameId) async {
    final library = await getLibrary();
    return library.any((game) => game.id == gameId);
  }

  static Future<void> addToLibrary(Game game) async {
    final box = await _getBox();
    final currentList = await getLibrary();
    if (!currentList.any((item) => item.id == game.id)) {
      currentList.add(game);
      final listMap = currentList.map((e) => e.toMap()).toList();
      await box.put(_libraryKey, listMap);
    }
  }

  static Future<void> removeFromLibrary(int gameId) async {
    final box = await _getBox();
    final currentList = await getLibrary();
    currentList.removeWhere((item) => item.id == gameId);
    final listMap = currentList.map((e) => e.toMap()).toList();
    await box.put(_libraryKey, listMap);
  }

  static Future<bool> toggleLibraryStatus(Game game) async {
    final isSaved = await isInLibrary(game.id);
    if (isSaved) {
      await removeFromLibrary(game.id);
      return false;
    } else {
      await addToLibrary(game);
      return true;
    }
  }

  static Future<Game?> getGameById(int gameId) async {
    final library = await getLibrary();
    try {
      return library.firstWhere((item) => item.id == gameId);
    } catch (_) {
      return null;
    }
  }
}
