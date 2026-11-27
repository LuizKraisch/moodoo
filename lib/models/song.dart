class Song {
  final String spotifyId;
  final String title;
  final String artist;
  final String? album;
  final String? coverUrl;
  final String? previewUrl;
  final String? spotifyUrl;
  final int? durationMs;

  const Song({
    required this.spotifyId,
    required this.title,
    required this.artist,
    this.album,
    this.coverUrl,
    this.previewUrl,
    this.spotifyUrl,
    this.durationMs,
  });

  bool get hasPreview => previewUrl != null && previewUrl!.isNotEmpty;

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
      spotifyId: data['spotify_id'] as String,
      title: data['title'] as String? ?? '',
      artist: data['artist'] as String? ?? '',
      album: data['album'] as String?,
      coverUrl: data['cover_url'] as String?,
      previewUrl: data['preview_url'] as String?,
      spotifyUrl: data['spotify_url'] as String?,
      durationMs: data['duration_ms'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spotify_id': spotifyId,
      'title': title,
      'artist': artist,
      'album': album,
      'cover_url': coverUrl,
      'preview_url': previewUrl,
      'spotify_url': spotifyUrl,
      'duration_ms': durationMs,
    };
  }
}
