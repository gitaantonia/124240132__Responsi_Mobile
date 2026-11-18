import 'package:get/get.dart';
import '../models/game_model.dart';
import '../services/api_service.dart';

class GamesController extends GetxController {
  final RxList<Game> games = <Game>[].obs;
  final RxList<Game> filteredGames = <Game>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  Future<void> fetchGames() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await ApiService.fetchGames();
      games.assignAll(result);
      applyFilter();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void clearSearch() {
    searchQuery.value = '';
    applyFilter();
  }

  void applyFilter() {
    if (searchQuery.value.trim().isEmpty) {
      filteredGames.assignAll(games);
    } else {
      final q = searchQuery.value.toLowerCase().trim();
      filteredGames.assignAll(
        games.where((game) {
          final titleMatch = game.title.toLowerCase().contains(q);
          final genreMatch = game.genre.toLowerCase().contains(q);
          final platformMatch = game.platform.toLowerCase().contains(q);
          return titleMatch || genreMatch || platformMatch;
        }).toList(),
      );
    }
  }
}
