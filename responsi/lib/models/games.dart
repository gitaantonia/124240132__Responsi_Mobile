class games {
  final int id;
  final String title;
  final String short_description;
  final String thumbnail;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String release_date;

  games({
    required this.id,
    required this.title,
    required this.short_description,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.release_date,
  });

  static String cleanHtml(String? html) {
    if (html == null || html.isEmpty) return 'Tidak ada deskripsi.';
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  factory games.fromJson(Map<String, dynamic> json) {
    return games(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Tidak ada judul',
      short_description: cleanHtml(json['short_description']),
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? 'Tidak ada genre',
      platform: json['platform'] ?? 'Tidak ada platform',
      publisher: json['publisher'] ?? 'Tidak ada publisher',
      developer: json['developer'] ?? 'Tidak ada developer',
      release_date: json['release_date'] ?? 'Tidak ada tanggal rilis',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'short_description': short_description,
      'thumbnail': thumbnail,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': release_date,
    };
  }
  factory games.fromMap(Map<String, dynamic> map) {
    return games(
      id: map['id'] ?? 0,
      title: map['title'] ?? 'Tidak ada judul',
      short_description: map['short_description'] ?? 'Tidak ada deskripsi',
      thumbnail: map['thumbnail'] ?? '',
      genre: map['genre'] ?? 'Tidak ada genre',
      platform: map['platform'] ?? 'Tidak ada platform',
      publisher: map['publisher'] ?? 'Tidak ada publisher',
      developer: map['developer'] ?? 'Tidak ada developer',
      release_date: map['release_date'] ?? 'Tidak ada tanggal rilis',
    );
  }
}
