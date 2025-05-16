import 'package:flutter_test/flutter_test.dart';
import 'package:customer_app/core/network.dart';

void main() {
  test('Network request returns expected response', () async {
    final response = await Network.fetchData();
    expect(response, isNotNull);
    expect(response.statusCode, 200);
  });

  test('Network request handles error correctly', () async {
    final response = await Network.fetchDataWithError();
    expect(response, isNotNull);
    expect(response.statusCode, 404);
  });
}