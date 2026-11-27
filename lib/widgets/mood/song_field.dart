import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/song.dart';
import 'package:moodoo/services/song_preview_player.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/spotify_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class SongCover extends StatelessWidget {
  const SongCover({
    super.key,
    required this.song,
    this.size = 52,
    this.playable = false,
  });

  final Song song;
  final double size;
  final bool playable;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: size,
      height: size,
      color: Theme.of(context).colorScheme.secondary,
      child: Icon(
        Icons.music_note_rounded,
        color: Theme.of(context).textTheme.titleSmall?.color,
      ),
    );

    final cover = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: song.coverUrl == null
          ? placeholder
          : Image.network(
              song.coverUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => placeholder,
            ),
    );

    if (!playable) return cover;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          cover,
          _CoverPreviewButton(song: song, size: size * 0.55),
        ],
      ),
    );
  }
}

class _CoverPreviewButton extends StatelessWidget {
  const _CoverPreviewButton({required this.song, required this.size});

  final Song song;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final player = SongPreviewPlayer();
    final iconSize = size * 0.62;

    return ListenableBuilder(
      listenable: player,
      builder: (context, _) {
        final status = player.statusFor(song);
        final unavailable = status == PreviewStatus.unavailable;

        final Widget child = switch (status) {
          PreviewStatus.loading => LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: iconSize,
          ),
          PreviewStatus.playing => Icon(
            Icons.pause_rounded,
            color: Colors.white,
            size: iconSize,
          ),
          PreviewStatus.unavailable => Icon(
            Icons.music_off_rounded,
            color: Colors.white.withValues(alpha: 0.7),
            size: iconSize * 0.85,
          ),
          _ => Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: iconSize,
          ),
        };

        final label = switch (status) {
          PreviewStatus.playing => l10n.pausePreview,
          PreviewStatus.unavailable => l10n.previewUnavailable,
          _ => l10n.playPreview,
        };

        return Semantics(
          button: !unavailable,
          label: label,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: unavailable ? null : () => player.toggle(song),
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: unavailable ? 0.35 : 0.55),
                shape: BoxShape.circle,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class SpotifyOpenButton extends StatelessWidget {
  const SpotifyOpenButton({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    if (song.spotifyUrl == null) return const SizedBox.shrink();
    return Semantics(
      button: true,
      label: AppLocalizations.of(context)!.openInSpotify,
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(song.spotifyUrl!),
          mode: LaunchMode.externalApplication,
        ),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: SpotifyIcon(size: 24),
        ),
      ),
    );
  }
}

class SongField extends StatelessWidget {
  const SongField({
    super.key,
    required this.song,
    this.onRemove,
    this.onPick,
  });

  final Song? song;
  final VoidCallback? onPick;
  final VoidCallback? onRemove;

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    if (song == null) {
      return MoodooButton(
        text: l10n.addSongForDay,
        onTap: onPick,
        leading: const SpotifyIcon(size: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: textTheme.bodySmall,
        padding: const EdgeInsets.symmetric(vertical: 14),
        bouncePeakScale: 1.04,
      );
    }

    final current = song!;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SongCover(song: current, playable: true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  current.title,
                  style: textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  current.artist,
                  style: textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SpotifyOpenButton(song: current),
          if (onPick != null) ...[
            const SizedBox(width: 10),
            _circleButton(Icons.edit, onPick!),
          ],
          if (onRemove != null) ...[
            SizedBox(width: onPick != null ? 6 : 10),
            _circleButton(Icons.close, onRemove!),
          ],
        ],
      ),
    );
  }
}
