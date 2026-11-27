class Song {
  final String spotifyId;
  final String? isrc;
  final String title;
  final String artist;
  final String? album;
  final String? coverUrl;
  final String? spotifyUrl;
  final int? durationMs;

  const Song({
    required this.spotifyId,
    this.isrc,
    required this.title,
    required this.artist,
    this.album,
    this.coverUrl,
    this.spotifyUrl,
    this.durationMs,
  });

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
      spotifyId: data['spotify_id'] as String,
      isrc: data['isrc'] as String?,
      title: data['title'] as String? ?? '',
      artist: data['artist'] as String? ?? '',
      album: data['album'] as String?,
      coverUrl: data['cover_url'] as String?,
      spotifyUrl: data['spotify_url'] as String?,
      durationMs: data['duration_ms'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spotify_id': spotifyId,
      'isrc': isrc,
      'title': title,
      'artist': artist,
      'album': album,
      'cover_url': coverUrl,
      'spotify_url': spotifyUrl,
      'duration_ms': durationMs,
    };
  }
}
