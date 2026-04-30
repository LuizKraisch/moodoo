import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/auth_service.dart';
import 'package:moodoo/services/firebase_service.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/moodoo_text.dart';

class _DeleteAllMoodsSheet extends StatelessWidget {
  const _DeleteAllMoodsSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodooButton(
            text: l10n.deleteAllMoods,
            onTap: () => Navigator.of(context).pop(true),
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 12),
          MoodooButton(
            text: l10n.cancel,
            onTap: () => Navigator.of(context).pop(false),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.15),
            foregroundColor: Theme.of(context).textTheme.titleMedium!.color!,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
        ],
      ),
    );
  }
}

class _DeleteAccountSheet extends StatelessWidget {
  const _DeleteAccountSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodooButton(
            text: l10n.deleteAccount,
            onTap: () => Navigator.of(context).pop(true),
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 12),
          MoodooButton(
            text: l10n.cancel,
            onTap: () => Navigator.of(context).pop(false),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.15),
            foregroundColor: Theme.of(context).textTheme.titleMedium!.color!,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
        ],
      ),
    );
  }
}

class DangerZone extends StatefulWidget {
  const DangerZone({super.key});

  @override
  State<DangerZone> createState() => _DangerZoneState();
}

class _DangerZoneState extends State<DangerZone> {
  bool _expanded = false;

  void _deleteAllMoods(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.deleteAllMoods,
      subtitle: l10n.areYouSure,
      child: const _DeleteAllMoodsSheet(),
    );

    if (confirmed != true) return;

    try {
      await FirebaseService().deleteAllMoods();
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  void _deleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.deleteAccount,
      subtitle: l10n.areYouSureReauth,
      child: const _DeleteAccountSheet(),
    );

    if (confirmed != true) return;

    try {
      await FirebaseService().deleteAllMoods();
      await AuthService().deleteUser();
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final redBg = Colors.red.withValues(alpha: 0.15);
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(iconTheme: const IconThemeData(color: Colors.red)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ExpansionPanelList(
          elevation: 0,
          dividerColor: Colors.transparent,
          expandedHeaderPadding: EdgeInsets.zero,
          materialGapSize: 0,
          expansionCallback: (_, _) => setState(() => _expanded = !_expanded),
          children: [
            ExpansionPanel(
              backgroundColor: redBg,
              canTapOnHeader: true,
              isExpanded: _expanded,
              headerBuilder: (context, _) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: MoodooText(
                  l10n.dangerZone,
                  variant: MoodooTextVariant.headlineSmall,
                  color: Colors.red,
                ),
              ),
              body: Container(
                color: redBg,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    MoodooText(
                      l10n.deleteAllMoodsDescription,
                      variant: MoodooTextVariant.titleSmall,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 14),
                    MoodooButton(
                      text: l10n.deleteAllMoods,
                      onTap: () => _deleteAllMoods(context),
                      backgroundColor: Colors.red.withValues(alpha: 0.25),
                      foregroundColor: Colors.red,
                      bouncePeakScale: 1.04,
                    ),
                    const SizedBox(height: 24),
                    MoodooText(
                      l10n.deleteAccountDescription,
                      variant: MoodooTextVariant.titleSmall,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 14),
                    MoodooButton(
                      text: l10n.deleteAccount,
                      onTap: () => _deleteAccount(context),
                      backgroundColor: Colors.red.withValues(alpha: 0.25),
                      foregroundColor: Colors.red,
                      bouncePeakScale: 1.04,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
