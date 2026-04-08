import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodoo/pages/home_page.dart';

void main() {
  testWidgets('checks if home page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('hi, kyle!'), findsOneWidget);
    expect(find.text("here's your mood overview"), findsOneWidget);
  });
}
