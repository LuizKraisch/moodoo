import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodoo/pages/auth_gate.dart';

void main() {
  testWidgets('checks if auth gate redirects to login page', (
    WidgetTester tester,
  ) async {
    // Pass a fake stream so Firebase.initializeApp() is not required
    await tester.pumpWidget(
      MaterialApp(
        home: AuthGate(authStream: Stream<User?>.value(null)),
      ),
    );

    expect(find.text('moodoo'), findsOneWidget);
    expect(
      find.text("track your days, create your own mood calendar"),
      findsOneWidget,
    );
  });
}
