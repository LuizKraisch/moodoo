import 'package:moodoo/preferences/onboarding_preferences.dart';
import 'package:moodoo/pages/login_page.dart';
import 'package:moodoo/pages/home_page.dart';
import 'package:moodoo/pages/onboarding_page.dart';
import 'package:moodoo/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Stream<bool> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = AuthService().authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: _authStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          if (snapshot.data == true) {
            return ValueListenableBuilder<bool>(
              valueListenable: onboardingFinishedNotifier,
              builder: (context, finished, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 480),
                  transitionBuilder: (child, animation) {
                    if (child.key == const ValueKey('home')) {
                      return SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.elasticOut,
                              ),
                            ),
                        child: child,
                      );
                    }
                    return child;
                  },
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      children: [...previousChildren, ?currentChild],
                    );
                  },
                  child: finished
                      ? const HomePage(key: ValueKey('home'))
                      : const OnboardingPage(key: ValueKey('onboarding')),
                );
              },
            );
          }

          return const LoginPage();
        },
      ),
    );
  }
}
