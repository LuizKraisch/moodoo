import 'package:moodoo/onboarding_preferences.dart';
import 'package:moodoo/pages/login_page.dart';
import 'package:moodoo/pages/home_page.dart';
import 'package:moodoo/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  final Stream<User?>? authStream;
  const AuthGate({super.key, this.authStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: authStream ?? FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ValueListenableBuilder<bool>(
              valueListenable: onboardingFinishedNotifier,
              builder: (context, finished, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 480),
                  transitionBuilder: (child, animation) {
                    if (child.key == const ValueKey('home')) {
                      return SlideTransition(
                        position: Tween<Offset>(
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
                      children: [
                        ...previousChildren,
                        ?currentChild,
                      ],
                    );
                  },
                  child: finished
                      ? const HomePage(key: ValueKey('home'))
                      : const OnboardingPage(key: ValueKey('onboarding')),
                );
              },
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
