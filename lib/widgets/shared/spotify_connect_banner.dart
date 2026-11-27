import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/preferences/spotify_preferences.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/services/spotify_service.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/spotify_icon.dart';

class SpotifyConnectBanner extends StatefulWidget {
  const SpotifyConnectBanner({super.key});

  @override
  State<SpotifyConnectBanner> createState() => _SpotifyConnectBannerState();
}

class _SpotifyConnectBannerState extends State<SpotifyConnectBanner> {
  bool _isConnecting = false;

  Future<void> _connect() async {
    setState(() => _isConnecting = true);
    try {
      await SpotifyService().connect();
    } catch (e) {
      if (mounted) showMoodooErrorSheet(context, e);
    } finally {
      if (mounted) setState(() => _isConnecting = false);
    }
  }

  void _dismiss() {
    saveSpotifyBannerDismissed(true);
    ApiService().updateAccount(spotifyBannerDismissed: true).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textColor = Theme.of(context).textTheme.titleSmall?.color;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SpotifyIcon(size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.spotifyBannerText,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 8),
          MoodooButton(
            text: l10n.connect,
            onTap: _connect,
            isLoading: _isConnecting,
            fullWidth: false,
            textStyle: Theme.of(context).textTheme.bodySmall,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
            foregroundColor: Theme.of(context).colorScheme.surface,
            bouncePeakScale: 1.08,
          ),
          GestureDetector(
            onTap: _dismiss,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.close,
                size: 18,
                color: textColor?.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
