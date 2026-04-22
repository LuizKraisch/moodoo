import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/widgets/login_page_presentation.dart';
import 'package:moodoo/widgets/moodoo_button.dart';
import 'package:moodoo/widgets/moodoo_text.dart';
import 'package:moodoo/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithGoogle();
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginPagePresentation(),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoodooText(
                    'moodoo',
                    variant: MoodooTextVariant.displayLarge,
                    fontSize: 50,
                  ),
                  const SizedBox(height: 5),
                  MoodooText(
                    l10n.loginSubtitle,
                    variant: MoodooTextVariant.titleMedium,
                    fontSize: 20,
                  ),
                  const SizedBox(height: 20),
                  MoodooButton(
                    text: l10n.loginWithGoogle,
                    onTap: () => login(context),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    leading: Image.asset(
                      'assets/logos/google-g-logo.png',
                      height: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
