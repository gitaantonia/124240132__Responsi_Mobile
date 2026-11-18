class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
  });

  static String cleanHtml(String? text) {
    if (text == null || text.isEmpty) return 'Tidak ada deskripsi.';
    return text
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? 'Tidak ada judul',
      thumbnail: json['thumbnail'] ?? '',
      shortDescription: cleanHtml(json['short_description']),
      genre: json['genre'] ?? 'Tidak ada genre',
      platform: json['platform'] ?? 'Tidak ada platform',
      publisher: json['publisher'] ?? 'Tidak ada publisher',
      developer: json['developer'] ?? 'Tidak ada developer',
      releaseDate: json['release_date'] ?? 'Tidak ada tanggal rilis',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'short_description': shortDescription,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': releaseDate,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'] ?? 'Tidak ada judul',
      thumbnail: map['thumbnail'] ?? '',
      shortDescription: map['short_description'] ?? 'Tidak ada deskripsi',
      genre: map['genre'] ?? 'Tidak ada genre',
      platform: map['platform'] ?? 'Tidak ada platform',
      publisher: map['publisher'] ?? 'Tidak ada publisher',
      developer: map['developer'] ?? 'Tidak ada developer',
      releaseDate: map['release_date'] ?? 'Tidak ada tanggal rilis',
    );
  }
}
