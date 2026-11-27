import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moodoo/models/song.dart';

class SongPreviewPlayer {
  static final SongPreviewPlayer _instance = SongPreviewPlayer._internal();
  factory SongPreviewPlayer() => _instance;
  SongPreviewPlayer._internal() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) stop();
    });
  }

  final _player = AudioPlayer();
  final playingId = ValueNotifier<String?>(null);

  Future<void> toggle(Song song) async {
    if (!song.hasPreview) return;
    if (playingId.value == song.spotifyId) {
      await stop();
      return;
    }
    playingId.value = song.spotifyId;
    try {
      await _player.setUrl(song.previewUrl!);
      if (playingId.value != song.spotifyId) return;
      await _player.play();
    } catch (_) {
      if (playingId.value == song.spotifyId) playingId.value = null;
    }
  }

  Future<void> stop() async {
    playingId.value = null;
    await _player.stop();
  }
}
