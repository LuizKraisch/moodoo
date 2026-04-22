import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/firebase_service.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/widgets/moodoo_modal.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class _DeleteConfirmSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodooButton(
            text: l10n.deleteMood,
            onTap: () => Navigator.of(context).pop(true),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          const SizedBox(height: 10),
          MoodooButton(
            text: l10n.cancel,
            onTap: () => Navigator.of(context).pop(false),
            backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
            foregroundColor: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
        ],
      ),
    );
  }
}

class MoodSheet extends StatefulWidget {
  final DateTime date;
  final Mood? mood;

  const MoodSheet({super.key, required this.date, this.mood});

  @override
  State<MoodSheet> createState() => _MoodSheetState();
}

class _MoodSheetState extends State<MoodSheet> {
  String? _selected;
  final _controller = TextEditingController();
  final _firebaseService = FirebaseService();
  bool _isLoading = false;

  static const _grades = ['S', 'A', 'B', 'C', 'D', 'F'];

  bool get _isEditing => widget.mood != null;

  bool get _hasChanges {
    if (!_isEditing) return true;
    return _selected != widget.mood!.score ||
        _controller.text != widget.mood!.notes;
  }

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _selected = widget.mood!.score;
      _controller.text = widget.mood!.notes;
      _controller.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selected == null) return;
    setState(() => _isLoading = true);
    if (_isEditing) {
      await _firebaseService.updateMood(
        widget.mood!.id,
        _controller.text,
        _selected!,
      );
    } else {
      await _firebaseService.addMood(
        '',
        Timestamp.fromDate(widget.date),
        _selected!,
        _controller.text,
      );
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showMoodooModal<bool>(
      context,
      title: l10n.deleteMood,
      subtitle: l10n.areYouSure,
      child: _DeleteConfirmSheet(),
    );
    if (confirmed != true) return;
    setState(() => _isLoading = true);
    await _firebaseService.deleteMood(widget.mood!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 24 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _grades.map((grade) {
              final isSelected = _selected == grade;
              return TapBounce(
                onTap: () => setState(() => _selected = grade),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).textTheme.displayLarge!.color!
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: GradeCard(
                    grade: grade,
                    size: 48,
                    borderRadius: 14,
                    fontSize: 22,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          MoodooText(
            MoodService.formatDateLabel(l10n, widget.date),
            variant: MoodooTextVariant.titleSmall,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            maxLines: 3,
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: l10n.writeNotes,
              hintStyle: Theme.of(context).textTheme.titleSmall,
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
          const SizedBox(height: 16),
          MoodooButton(
            text: _isEditing ? l10n.saveChanges : l10n.saveMood,
            onTap: (_selected == null || _isLoading || !_hasChanges)
                ? null
                : _save,
            backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
            foregroundColor: Theme.of(context).colorScheme.surface,
            disabledBackgroundColor: Theme.of(
              context,
            ).textTheme.displayLarge!.color!.withValues(alpha: 0.15),
            padding: const EdgeInsets.symmetric(vertical: 16),
            bouncePeakScale: 1.04,
          ),
          if (_isEditing) ...[
            const SizedBox(height: 10),
            MoodooButton(
              text: l10n.deleteMood,
              onTap: _isLoading ? null : _delete,
              backgroundColor: Colors.red.withValues(alpha: 0.15),
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              bouncePeakScale: 1.04,
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
