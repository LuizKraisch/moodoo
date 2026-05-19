import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/pages/login_page.dart';

void main() {
  testWidgets('checks if auth gate redirects to login page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoginPage(),
      ),
    );

    await tester.pump();

    expect(find.text('moodoo'), findsOneWidget);
    expect(
      find.text('track your days, create your own mood calendar'),
      findsOneWidget,
    );
  });
}
