import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

String _humanizeError(AppLocalizations l10n, Object e) {
  if (e is ApiException) {
    if (e.statusCode == 401) return l10n.errorInvalidCredential;
    if (e.statusCode == 404) return l10n.errorNotFound;
    if (e.message.isNotEmpty) return e.message;
    return l10n.errorGeneric;
  }

  if (e is SignInWithAppleAuthorizationException) {
    if (e.code == AuthorizationErrorCode.canceled) return l10n.errorSignInCancelled;
    if (e.code == AuthorizationErrorCode.notHandled) return l10n.errorNetworkFailed;
    return l10n.errorGeneric;
  }

  if (e is PlatformException) {
    switch (e.code) {
      case 'sign_in_canceled':
      case 'user_cancelled':
        return l10n.errorSignInCancelled;
      case 'network_error':
        return l10n.errorNetworkFailed;
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
    subtitle: _humanizeError(l10n, error),
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
