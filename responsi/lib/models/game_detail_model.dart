import 'game_model.dart';

class GameScreenshot {
  final int id;
  final String image;

  GameScreenshot({required this.id, required this.image});

  factory GameScreenshot.fromJson(Map<String, dynamic> json) {
    return GameScreenshot(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      image: json['image'] ?? '',
    );
  }
}

class MinimumSystemRequirements {
  final String? os;
  final String? processor;
  final String? memory;
  final String? graphics;
  final String? storage;

  MinimumSystemRequirements({
    this.os,
    this.processor,
    this.memory,
    this.graphics,
    this.storage,
  });

  factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json) {
    return MinimumSystemRequirements(
      os: json['os'],
      processor: json['processor'],
      memory: json['memory'],
      graphics: json['graphics'],
      storage: json['storage'],
    );
  }
}

class GameDetail {
  final int id;
  final String title;
  final String thumbnail;
  final String status;
  final String shortDescription;
  final String description;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final List<GameScreenshot> screenshots;
  final MinimumSystemRequirements? minimumSystemRequirements;

  GameDetail({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.status,
    required this.shortDescription,
    required this.description,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.screenshots,
    this.minimumSystemRequirements,
  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    var screenshotsList = <GameScreenshot>[];
    if (json['screenshots'] != null && json['screenshots'] is List) {
      screenshotsList = (json['screenshots'] as List)
          .map((item) => GameScreenshot.fromJson(item))
          .toList();
    }

    return GameDetail(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? 'Tidak ada judul',
      thumbnail: json['thumbnail'] ?? '',
      status: json['status'] ?? '',
      shortDescription: Game.cleanHtml(json['short_description']),
      description: Game.cleanHtml(json['description']),
      gameUrl: json['game_url'] ?? '',
      genre: json['genre'] ?? 'Tidak ada genre',
      platform: json['platform'] ?? 'Tidak ada platform',
      publisher: json['publisher'] ?? 'Tidak ada publisher',
      developer: json['developer'] ?? 'Tidak ada developer',
      releaseDate: json['release_date'] ?? 'Tidak ada tanggal rilis',
      screenshots: screenshotsList,
      minimumSystemRequirements: json['minimum_system_requirements'] != null
          ? MinimumSystemRequirements.fromJson(json['minimum_system_requirements'])
          : null,
    );
  }

  Game toGame() {
    return Game(
      id: id,
      title: title,
      thumbnail: thumbnail,
      shortDescription: shortDescription,
      genre: genre,
      platform: platform,
      publisher: publisher,
      developer: developer,
      releaseDate: releaseDate,
    );
  }
}
