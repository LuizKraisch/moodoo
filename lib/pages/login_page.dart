import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/services/auth_service.dart';
import 'package:moodoo/theme_preferences.dart'
    show themeModeNotifier, saveTheme;
import 'package:moodoo/widgets/login_page_presentation.dart';
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/sheets/moodoo_error_sheet.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoadingGoogle = false;
  bool _isLoadingApple = false;
  bool _appleAvailable = false;

  @override
  void initState() {
    super.initState();
    SignInWithApple.isAvailable().then((available) {
      if (mounted) setState(() => _appleAvailable = available);
    });
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isLoadingGoogle = true);
    try {
      await AuthService().signInWithGoogle();
      themeModeNotifier.value = ThemeMode.system;
      await saveTheme(ThemeMode.system);
    } catch (e) {
      if (mounted) showMoodooErrorSheet(context, e);
    } finally {
      if (mounted) setState(() => _isLoadingGoogle = false);
    }
  }

  Future<void> _loginWithApple() async {
    setState(() => _isLoadingApple = true);
    try {
      await AuthService().signInWithApple();
      themeModeNotifier.value = ThemeMode.system;
      await saveTheme(ThemeMode.system);
    } catch (e) {
      if (mounted) showMoodooErrorSheet(context, e);
    } finally {
      if (mounted) setState(() => _isLoadingApple = false);
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
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/logos/moodoo-cow-light.png',
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      MoodooText(
                        'moodoo',
                        variant: MoodooTextVariant.displayLarge,
                        fontSize: 50,
                      ),
                    ],
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
                    onTap: _loginWithGoogle,
                    isLoading: _isLoadingGoogle,
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1C1C1C),
                    bouncePeakScale: 1.1,
                    leading: Image.asset(
                      'assets/logos/google-g-logo.png',
                      height: 22,
                    ),
                  ),
                  if (_appleAvailable) ...[
                    const SizedBox(height: 12),
                    MoodooButton(
                      text: l10n.loginWithApple,
                      onTap: _loginWithApple,
                      isLoading: _isLoadingApple,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      bouncePeakScale: 1.1,
                      leading: const Icon(
                        Icons.apple,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
