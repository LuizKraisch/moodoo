import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/models/mood.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/services/mood_service.dart';
import 'package:moodoo/services/native_image_picker.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/grade_card.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/tap_bounce.dart';

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
            backgroundColor: Colors.red.withValues(alpha: 0.15),
            foregroundColor: Colors.red,
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
  final _apiService = ApiService();
  bool _isLoading = false;
  File? _imageFile;
  bool _removePhoto = false;

  static const _grades = ['S', 'A', 'B', 'C', 'D', 'F'];

  bool get _isEditing => widget.mood != null;

  bool get _hasChanges {
    if (!_isEditing) return true;
    return _selected != widget.mood!.score ||
        _controller.text != widget.mood!.notes ||
        _imageFile != null ||
        _removePhoto;
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

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _removePhoto = true;
    });
  }

  static const _allowedExtensions = {
    'jpg',
    'jpeg',
    'png',
    'webp',
    'heic',
    'heif',
    'avif',
    'gif',
    'tiff',
    'tif',
    'bmp',
  };

  Future<void> _pickImage({required bool fromCamera}) async {
    final file = fromCamera
        ? await NativeImagePicker.pickFromCamera()
        : await NativeImagePicker.pickFromGallery();
    if (file == null) return;
    final ext = file.path.split('.').last.toLowerCase();
    if (!_allowedExtensions.contains(ext)) {
      if (mounted) showMoodooErrorSheet(context, InvalidImageFormatException());
      return;
    }
    if (mounted) {
      setState(() {
        _imageFile = file;
        _removePhoto = false;
      });
    }
  }

  Future<void> _showImageSourcePicker() async {
    final l10n = AppLocalizations.of(context)!;
    final source = await showMoodooModal<String>(
      context,
      title: l10n.addPhoto,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoodooButton(
              text: l10n.takePhoto,
              onTap: () => Navigator.of(context).pop('camera'),
              backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
              foregroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              bouncePeakScale: 1.04,
            ),
            const SizedBox(height: 10),
            MoodooButton(
              text: l10n.chooseFromGallery,
              onTap: () => Navigator.of(context).pop('gallery'),
              backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
              foregroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              bouncePeakScale: 1.04,
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    if (source == 'camera') _pickImage(fromCamera: true);
    if (source == 'gallery') _pickImage(fromCamera: false);
  }

  Future<void> _save() async {
    if (_selected == null) return;
    setState(() => _isLoading = true);
    try {
      final imageFile = _imageFile;
      if (_isEditing) {
        await _apiService.updateMood(
          widget.mood!.id,
          _controller.text,
          _selected!,
          image: imageFile,
          removePhoto: _removePhoto,
        );
      } else {
        await _apiService.addMood(
          widget.date,
          _selected!,
          _controller.text,
          image: imageFile,
        );
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // ignore: use_build_context_synchronously
        showMoodooErrorSheet(context, e);
      }
    }
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
    try {
      await _apiService.deleteMood(widget.mood!.id);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // ignore: use_build_context_synchronously
        showMoodooErrorSheet(context, e);
      }
    }
  }

  Widget _buildImageArea(BuildContext context) {
    final existingUrl = widget.mood?.photoUrl;
    final hasExisting = existingUrl != null && existingUrl.isNotEmpty;

    if ((_imageFile != null || hasExisting) && !_removePhoto) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, fit: BoxFit.cover)
                : Image.network(
                    existingUrl!,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.55),
                        child: Center(
                          child: LoadingAnimationWidget.waveDots(
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  ),
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: _showImageSourcePicker,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 14),
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: GestureDetector(
                onTap: _removeImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;

    return MoodooButton(
      text: l10n.addPhoto,
      onTap: _showImageSourcePicker,
      leading: const Icon(Icons.add_photo_alternate_outlined, size: 26),
      verticalLeading: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: Theme.of(context).textTheme.bodySmall,
      padding: EdgeInsets.zero,
      bouncePeakScale: 1.04,
    );
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
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 8.0;
              const n = 6;
              final cardOuter = (constraints.maxWidth - gap * (n - 1)) / n;
              final cardInner = cardOuter - 6;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _grades.map((grade) {
                  final isSelected = _selected == grade;
                  return TapBounce(
                    onTap: () => setState(() => _selected = grade),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cardOuter * 0.33),
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
                        size: cardInner,
                        borderRadius: cardInner * 0.29,
                        fontSize: cardInner * 0.46,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 10),
          MoodooText(
            MoodService.formatDateLabel(l10n, widget.date),
            variant: MoodooTextVariant.titleSmall,
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final hasImage =
                  _imageFile != null ||
                  (widget.mood?.photoUrl?.isNotEmpty == true && !_removePhoto);
              final imageH = hasImage
                  ? (constraints.maxWidth - 8) * 3 / 10
                  : null;

              final row = Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      controller: _controller,
                      maxLines: imageH != null ? null : 3,
                      expands: imageH != null,
                      textAlignVertical: TextAlignVertical.top,
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
                  ),
                  const SizedBox(width: 8),
                  Expanded(flex: 3, child: _buildImageArea(context)),
                ],
              );

              return imageH != null
                  ? SizedBox(height: imageH, child: row)
                  : IntrinsicHeight(child: row);
            },
          ),
          const SizedBox(height: 16),
          MoodooButton(
            text: _isEditing ? l10n.saveChanges : l10n.saveMood,
            onTap: (_selected == null || !_hasChanges) ? null : _save,
            isLoading: _isLoading,
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
