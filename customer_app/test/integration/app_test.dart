import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('hello world integration test', (WidgetTester tester) async {
    // Add your integration test code here
    expect(true, isTrue);
  });
}