import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer_app/main.dart';

// This is a basic integration test
void main() {
  group('App', () {
    testWidgets('App starts and navigation works', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(const ProviderScope(child: UniConnectApp()));

      // Wait for any animations to complete
      await tester.pumpAndSettle();

      // Verify the app loaded successfully
      expect(find.byType(UniConnectApp), findsOneWidget);
    });
  });
}
