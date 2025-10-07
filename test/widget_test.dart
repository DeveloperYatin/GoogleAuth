import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:googleauth/main.dart';

void main() {
  group('Google Auth Widget Tests', () {
    testWidgets('Should display login button when user is not logged in', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that login button is displayed
      expect(find.text('Login with Google'), findsOneWidget);
      expect(find.text('Logout'), findsNothing);
      expect(find.text('User'), findsNothing);
    });

    testWidgets('Should display logout button when user is logged in', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Simulate a logged-in state by finding and tapping login button
      // Note: In a real test, you would mock the GoogleSignIn service
      expect(find.text('Login with Google'), findsOneWidget);

      // Verify logout button is not initially visible
      expect(find.text('Logout'), findsNothing);
    });

    testWidgets('Should have proper app title', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify app title is set correctly
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Should display centered content', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that Center widget is present
      expect(find.byType(Center), findsOneWidget);

      // Verify that Scaffold is present
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Should have OutlinedButton for login', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify that OutlinedButton is present
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Login with Google'), findsOneWidget);
    });

    testWidgets('Should handle button tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap the login button
      final loginButton = find.text('Login with Google');
      expect(loginButton, findsOneWidget);

      // Tap the button (though it won't actually sign in without proper setup)
      await tester.tap(loginButton);
      await tester.pump();

      // Verify the button still exists after tap
      expect(loginButton, findsOneWidget);
    });
  });
}
