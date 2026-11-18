import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/library_controller.dart';
import '../widgets/safe_image.dart';
import 'detail.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryController libraryController = Get.find<LibraryController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Library Anda',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        if (libraryController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF2979FF),
            ),
          );
        }

        if (libraryController.libraryGames.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_esports_outlined,
                  size: 64,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Library Anda masih kosong.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Dapatkan game dari halaman Beranda.',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: const Color(0xFF2979FF),
          backgroundColor: const Color(0xFF161616),
          onRefresh: libraryController.loadLibrary,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            itemCount: libraryController.libraryGames.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final game = libraryController.libraryGames[index];
              return Material(
                color: const Color(0xFF141414),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Get.to(() => DetailScreen(gameId: game.id));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF222222)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SafeImage(
                          imageUrl: game.thumbnail,
                          width: 68,
                          height: 68,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                game.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2.5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  game.genre,
                                  style: const TextStyle(
                                    color: Color(0xFF93C5FD),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                game.platform,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Color(0xFFEF4444),
                            size: 22,
                          ),
                          tooltip: 'Hapus dari Library',
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Hapus Game',
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              middleText: 'Hapus "${game.title}" dari library?',
                              middleTextStyle: const TextStyle(color: Colors.white70),
                              backgroundColor: const Color(0xFF1E1E1E),
                              radius: 8,
                              textCancel: 'Batal',
                              cancelTextColor: Colors.grey,
                              textConfirm: 'Hapus',
                              confirmTextColor: Colors.white,
                              buttonColor: const Color(0xFFEF4444),
                              onConfirm: () {
                                Get.back();
                                libraryController.removeFromLibrary(game.id, game.title);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
