import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:copartner/main.dart';

void main() {
  testWidgets('Splash screen displays splash image',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash image is displayed.
    expect(find.byType(Image), findsOneWidget);
  });
}
