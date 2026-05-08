import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';

Future<TimeOfDay?> showTimePickerSheet(
  BuildContext context, {
  required TimeOfDay initialTime,
  required String title,
  required String doneLabel,
}) {
  if (Platform.isIOS) {
    return _showCupertinoSheet(
      context,
      initialTime: initialTime,
      title: title,
      doneLabel: doneLabel,
    );
  }
  return showTimePicker(context: context, initialTime: initialTime);
}

Future<TimeOfDay?> _showCupertinoSheet(
  BuildContext context, {
  required TimeOfDay initialTime,
  required String title,
  required String doneLabel,
}) {
  return showMoodooModal<TimeOfDay>(
    context,
    title: title,
    child: _CupertinoTimeSheetContent(
      initialTime: initialTime,
      doneLabel: doneLabel,
    ),
  );
}

class _CupertinoTimeSheetContent extends StatefulWidget {
  const _CupertinoTimeSheetContent({
    required this.initialTime,
    required this.doneLabel,
  });

  final TimeOfDay initialTime;
  final String doneLabel;

  @override
  State<_CupertinoTimeSheetContent> createState() =>
      _CupertinoTimeSheetContentState();
}

class _CupertinoTimeSheetContentState
    extends State<_CupertinoTimeSheetContent> {
  late TimeOfDay _picked;

  @override
  void initState() {
    super.initState();
    _picked = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(
                2000,
                1,
                1,
                widget.initialTime.hour,
                widget.initialTime.minute,
              ),
              onDateTimeChanged: (dt) {
                _picked = TimeOfDay(hour: dt.hour, minute: dt.minute);
              },
            ),
          ),
          const SizedBox(height: 16),
          MoodooButton(
            text: widget.doneLabel,
            bouncePeakScale: 1.04,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onTap: () => Navigator.of(context).pop(_picked),
            backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
        ],
      ),
    );
  }
}
