import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// A sample widget to test
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      child: Text(text),
    );
  }
}

void main() {
  group('CustomTextButton', () {
    testWidgets('renders correctly with provided text', (
      WidgetTester tester,
    ) async {
      // Given
      bool wasPressed = false;

      // When
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextButton(
              text: 'Click Me',
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      // Then
      expect(find.text('Click Me'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);

      // Tap the button and check if onPressed callback was called
      await tester.tap(find.byType(TextButton));
      expect(wasPressed, isTrue);
    });
  });
}
