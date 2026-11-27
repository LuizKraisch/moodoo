import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/preferences/spotify_preferences.dart';
import 'package:moodoo/services/spotify_service.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';
import 'package:moodoo/widgets/shared/spotify_icon.dart';

class SpotifySettingsSection extends StatefulWidget {
  const SpotifySettingsSection({super.key});

  @override
  State<SpotifySettingsSection> createState() => _SpotifySettingsSectionState();
}

class _SpotifySettingsSectionState extends State<SpotifySettingsSection> {
  bool _isLoading = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _isLoading = true);
    try {
      await action();
    } catch (e) {
      if (mounted) showMoodooErrorSheet(context, e);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<bool>(
      valueListenable: spotifyConnectedNotifier,
      builder: (context, connected, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: spotifyDisplayNameNotifier,
          builder: (context, displayName, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SpotifyIcon(size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MoodooText(
                        connected
                            ? l10n.spotifyConnectedAs(displayName ?? '')
                            : l10n.spotifySettingsDescription,
                        variant: MoodooTextVariant.titleMedium,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                connected
                    ? MoodooButton(
                        text: l10n.disconnectSpotify,
                        isLoading: _isLoading,
                        onTap: () => _run(SpotifyService().disconnect),
                        fullWidth: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        bouncePeakScale: 1.04,
                        backgroundColor: Colors.red.withValues(alpha: 0.15),
                        foregroundColor: Colors.red,
                      )
                    : MoodooButton(
                        text: l10n.connectSpotify,
                        isLoading: _isLoading,
                        onTap: () => _run(SpotifyService().connect),
                        fullWidth: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        bouncePeakScale: 1.04,
                        backgroundColor: Theme.of(
                          context,
                        ).textTheme.displayLarge!.color!,
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
              ],
            );
          },
        );
      },
    );
  }
}
