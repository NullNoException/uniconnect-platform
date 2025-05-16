import 'package:flutter_test/flutter_test.dart';
import 'package:customer_app/widget/common_widgets/app_text_field.dart';

void main() {
  testWidgets('AppTextField renders correctly and responds to user input', (WidgetTester tester) async {
    await tester.pumpWidget(AppTextField());

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'Hello World');
    expect(find.text('Hello World'), findsOneWidget);
  });
}