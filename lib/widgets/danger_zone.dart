import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/auth_service.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

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
  bool _isDeleting = false;
  bool _isDeletingAccount = false;

  Future<void> _deleteAllMoods() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.deleteAllMoods,
      subtitle: l10n.areYouSure,
      child: const _DeleteAllMoodsSheet(),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);
    try {
      await ApiService().deleteAllMoods();
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDeleting = false);
      showMoodooErrorSheet(context, e);
    }
  }

  Future<void> _deleteAccount() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.deleteAccount,
      subtitle: l10n.areYouSureReauth,
      child: const _DeleteAccountSheet(),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeletingAccount = true);
    try {
      await ApiService().deleteAccount();
      await AuthService().signOut();
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDeletingAccount = false);
      showMoodooErrorSheet(context, e);
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
                      onTap: _isDeleting ? null : _deleteAllMoods,
                      isLoading: _isDeleting,
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
                      onTap: _isDeletingAccount ? null : _deleteAccount,
                      isLoading: _isDeletingAccount,
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
