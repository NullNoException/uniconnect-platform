import 'package:flutter_test/flutter_test.dart';
import 'package:customer_app/data/repositories/auth_repository.dart';

void main() {
  group('AuthRepository', () {
    test('should authenticate user with valid credentials', () async {
      final authRepository = AuthRepository();
      final result = await authRepository.authenticate('validUser', 'validPassword');
      expect(result, isTrue);
    });

    test('should not authenticate user with invalid credentials', () async {
      final authRepository = AuthRepository();
      final result = await authRepository.authenticate('invalidUser', 'invalidPassword');
      expect(result, isFalse);
    });
  });
}