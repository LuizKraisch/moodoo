import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';

String _humanizeFirebaseError(AppLocalizations l10n, Object e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'requires-recent-login':
        return l10n.errorRecentLogin;
      case 'network-request-failed':
        return l10n.errorNetworkFailed;
      case 'too-many-requests':
        return l10n.errorTooManyRequests;
      case 'user-not-found':
        return l10n.errorUserNotFound;
      case 'user-disabled':
        return l10n.errorUserDisabled;
      case 'invalid-credential':
        return l10n.errorInvalidCredential;
      case 'user-cancelled':
      case 'sign_in_canceled':
        return l10n.errorSignInCancelled;
      default:
        return l10n.errorGeneric;
    }
  }
  if (e is FirebaseException) {
    switch (e.code) {
      case 'permission-denied':
        return l10n.errorPermissionDenied;
      case 'unavailable':
        return l10n.errorServiceUnavailable;
      case 'not-found':
        return l10n.errorNotFound;
      case 'deadline-exceeded':
        return l10n.errorDeadlineExceeded;
      case 'resource-exhausted':
        return l10n.errorResourceExhausted;
      default:
        return l10n.errorGeneric;
    }
  }
  return l10n.errorGeneric;
}

void showMoodooErrorSheet(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context)!;
  showMoodooModal<void>(
    context,
    title: l10n.errorTitle,
    subtitle: _humanizeFirebaseError(l10n, error),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 40),
      child: MoodooButton(
        text: l10n.ok,
        onTap: () => Navigator.of(context).pop(),
        backgroundColor: Theme.of(context).textTheme.displayLarge!.color!,
        foregroundColor: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 16),
        bouncePeakScale: 1.04,
      ),
    ),
  );
}
