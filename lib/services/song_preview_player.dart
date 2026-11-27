import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moodoo/models/song.dart';
import 'package:moodoo/services/spotify_service.dart';

enum PreviewStatus { loading, playing, paused, unavailable }

class SongPreviewPlayer extends ChangeNotifier {
  static final SongPreviewPlayer _instance = SongPreviewPlayer._internal();
  factory SongPreviewPlayer() => _instance;
  SongPreviewPlayer._internal() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) stop();
    });
  }

  static const _urlTtl = Duration(minutes: 10);

  final _player = AudioPlayer();
  final _unavailable = <String>{};
  final _urls = <String, ({String url, DateTime fetchedAt})>{};
  String? _currentId;
  PreviewStatus? _currentStatus;

  String? get currentId => _currentId;

  PreviewStatus? statusFor(Song song) {
    if (_currentId == song.spotifyId) return _currentStatus;
    if (_unavailable.contains(song.spotifyId)) return PreviewStatus.unavailable;
    return null;
  }

  Future<void> toggle(Song song) async {
    final id = song.spotifyId;
    if (_currentId == id) {
      switch (_currentStatus) {
        case PreviewStatus.playing:
          _set(id, PreviewStatus.paused);
          await _player.pause();
        case PreviewStatus.paused:
          _set(id, PreviewStatus.playing);
          _player.play();
        default:
          await stop();
      }
      return;
    }
    if (_unavailable.contains(id)) return;

    await _player.stop();
    _set(id, PreviewStatus.loading);
    try {
      final url = await _resolveUrl(song);
      if (_currentId != id) return;
      if (url == null) {
        _unavailable.add(id);
        _set(null, null);
        return;
      }
      await _player.setUrl(url);
      if (_currentId != id) return;
      _set(id, PreviewStatus.playing);
      _player.play();
    } catch (_) {
      _urls.remove(id);
      if (_currentId == id) _set(null, null);
    }
  }

  Future<void> stop() async {
    _set(null, null);
    await _player.stop();
  }

  Future<String?> _resolveUrl(Song song) async {
    final cached = _urls[song.spotifyId];
    if (cached != null && DateTime.now().difference(cached.fetchedAt) < _urlTtl) {
      return cached.url;
    }
    final url = await SpotifyService().previewUrl(song);
    if (url != null) {
      _urls[song.spotifyId] = (url: url, fetchedAt: DateTime.now());
    }
    return url;
  }

  void _set(String? id, PreviewStatus? status) {
    _currentId = id;
    _currentStatus = status;
    notifyListeners();
  }
}
