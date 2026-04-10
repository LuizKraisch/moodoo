import 'package:flutter/material.dart';
import 'package:moodoo/widgets/grade_card.dart';
import 'package:moodoo/widgets/tap_bounce.dart';

class AddMoodSheet extends StatefulWidget {
  const AddMoodSheet({super.key});

  @override
  State<AddMoodSheet> createState() => _AddMoodSheetState();
}

class _AddMoodSheetState extends State<AddMoodSheet> {
  String? _selected;
  final _controller = TextEditingController();

  static const _grades = ['S', 'A', 'B', 'C', 'D', 'F'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 14, 24, 24 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 35,
              color: Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "how are you feeling today?",
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 20),
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
          Text("march 29, 2026", style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            maxLines: 3,
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: 'write something about it... (optional)',
              hintStyle: Theme.of(context).textTheme.titleSmall,
              filled: true,
              fillColor: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 16),
          TapBounce(
            peakScale: 1.04,
            onTap: _selected == null ? null : () => Navigator.pop(context),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selected == null ? null : () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  disabledBackgroundColor: Theme.of(context).textTheme.displayLarge!.color!.withValues(alpha: 0.15),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                ),
                child: const Text('save mood'),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
