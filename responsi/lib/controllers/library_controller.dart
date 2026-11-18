import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/game_model.dart';
import '../services/library_service.dart';
import '../services/notification_service.dart';

class LibraryController extends GetxController {
  final RxList<Game> libraryGames = <Game>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLibrary();
  }

  Future<void> loadLibrary() async {
    isLoading.value = true;
    try {
      final items = await LibraryService.getLibrary();
      libraryGames.assignAll(items);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  bool isGameInLibrary(int gameId) {
    return libraryGames.any((game) => game.id == gameId);
  }

  Future<void> addToLibrary(Game game) async {
    await LibraryService.addToLibrary(game);
    if (!libraryGames.any((g) => g.id == game.id)) {
      libraryGames.add(game);
    }

    await NotificationService.showNotification(
      id: game.id,
      title: 'Game Ditambahkan ke Library',
      body: '${game.title} telah berhasil ditambahkan ke Library kamu.',
    );

    Get.snackbar(
      'Berhasil',
      '${game.title} ditambahkan ke Library',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
    );
  }

  Future<void> removeFromLibrary(int gameId, [String? gameTitle]) async {
    final title = gameTitle ??
        (libraryGames.firstWhereOrNull((g) => g.id == gameId)?.title ?? 'Game');

    await LibraryService.removeFromLibrary(gameId);
    libraryGames.removeWhere((g) => g.id == gameId);

    await NotificationService.showNotification(
      id: gameId,
      title: 'Game Dihapus dari Library',
      body: '$title telah dihapus dari Library kamu.',
    );

    Get.snackbar(
      'Dihapus',
      '$title telah dihapus dari Library',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
    );
  }

  Future<void> toggleLibrary(Game game) async {
    if (isGameInLibrary(game.id)) {
      await removeFromLibrary(game.id, game.title);
    } else {
      await addToLibrary(game);
    }
  }
}
