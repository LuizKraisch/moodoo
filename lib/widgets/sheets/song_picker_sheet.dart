import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/song.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/services/song_preview_player.dart';
import 'package:moodoo/services/spotify_service.dart';
import 'package:moodoo/widgets/mood/song_field.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

Future<Song?> showSongPickerSheet(BuildContext context) {
  return showMoodooModal<Song>(
    context,
    title: AppLocalizations.of(context)!.chooseSong,
    child: const SongPickerSheet(),
  );
}

class SongPickerSheet extends StatefulWidget {
  const SongPickerSheet({super.key});

  @override
  State<SongPickerSheet> createState() => _SongPickerSheetState();
}

class _SongPickerSheetState extends State<SongPickerSheet> {
  final _controller = TextEditingController();
  final _spotify = SpotifyService();
  Timer? _debounce;
  List<Song>? _topTracks;
  List<Song>? _results;
  bool _isLoading = true;
  int _requestId = 0;

  String get _query => _controller.text.trim();

  @override
  void initState() {
    super.initState();
    _loadTopTracks();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    SongPreviewPlayer().stop();
    super.dispose();
  }

  Future<void> _loadTopTracks() async {
    final requestId = ++_requestId;
    try {
      final tracks = await _spotify.topTracks();
      if (!mounted) return;
      setState(() {
        _topTracks = tracks;
        if (requestId == _requestId) _isLoading = false;
      });
    } catch (e) {
      _handleError(e, requestId);
    }
  }

  void _onQueryChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), _search);
  }

  Future<void> _search() async {
    final query = _query;
    final requestId = ++_requestId;

    if (query.isEmpty) {
      setState(() {
        _results = null;
        _isLoading = _topTracks == null;
      });
      if (_topTracks == null) _loadTopTracks();
      return;
    }

    setState(() => _isLoading = true);
    try {
      final results = await _spotify.search(query);
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      _handleError(e, requestId);
    }
  }

  Future<void> _handleError(Object e, int requestId) async {
    if (!mounted || requestId != _requestId) return;
    setState(() => _isLoading = false);
    await showMoodooErrorSheet(context, e);
    if (mounted && e is SpotifyNotConnectedException) closeMoodooModal(context);
  }

  void _select(Song song) {
    SongPreviewPlayer().stop();
    closeMoodooModal(context, song);
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final songs = _query.isEmpty ? _topTracks : _results;

    if (_isLoading) {
      return Center(
        child: LoadingAnimationWidget.waveDots(
          color: Theme.of(context).textTheme.displayLarge!.color!,
          size: 30,
        ),
      );
    }

    if (songs == null || songs.isEmpty) {
      return Center(
        child: MoodooText(
          l10n.noSongsFound,
          variant: MoodooTextVariant.titleSmall,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: songs.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (context, index) =>
          _SongRow(song: songs[index], onTap: () => _select(songs[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 24 + media.viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            onChanged: _onQueryChanged,
            textInputAction: TextInputAction.search,
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: l10n.searchSongs,
              hintStyle: Theme.of(context).textTheme.titleSmall,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).textTheme.titleSmall?.color,
              ),
              filled: true,
              fillColor: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.55),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 14),
          if (_query.isEmpty) ...[
            MoodooText(l10n.yourTopTracks, variant: MoodooTextVariant.titleSmall),
            const SizedBox(height: 8),
          ],
          SizedBox(
            height: media.size.height * 0.42,
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }
}

class _SongRow extends StatelessWidget {
  const _SongRow({required this.song, required this.onTap});

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              SongCover(song: song, size: 46, playable: true),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      song.artist,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
