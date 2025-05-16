import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:customer_app/domain/entities/user.dart';
import 'package:customer_app/domain/usecases/auth_usecases.dart';
import 'package:customer_app/core/data/mock_auth_repository.dart';
import 'package:customer_app/domain/repositories/auth_repository.dart';

// Auth repository and use cases providers will be defined elsewhere

// Auth state providers
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
      final getCurrentUserUseCase = ref.watch(getCurrentUserUseCaseProvider);
      final signOutUseCase = ref.watch(signOutUseCaseProvider);
      return AuthNotifier(
        getCurrentUserUseCase: getCurrentUserUseCase,
        signOutUseCase: signOutUseCase,
      );
    });

final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final isAuthenticatedUseCase = ref.watch(isAuthenticatedUseCaseProvider);
  return isAuthenticatedUseCase();
});

// Auth notifier
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;

  AuthNotifier({
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
  }) : super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final result = await getCurrentUserUseCase();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }

  Future<bool> signIn(User user) async {
    state = AsyncValue.data(user);
    return true;
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await signOutUseCase();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  Future<void> refreshUser() async {
    if (state.hasValue && state.value != null) {
      state = const AsyncValue.loading();
      final result = await getCurrentUserUseCase();
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (user) => state = AsyncValue.data(user),
      );
    }
  }
}

// Login state providers
final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<User?>>((ref) {
      final signInUseCase = ref.watch(signInUseCaseProvider);
      final authNotifier = ref.watch(authStateProvider.notifier);
      return LoginNotifier(
        signInUseCase: signInUseCase,
        authNotifier: authNotifier,
      );
    });

class LoginNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignInUseCase signInUseCase;
  final AuthNotifier authNotifier;

  LoginNotifier({required this.signInUseCase, required this.authNotifier})
    : super(const AsyncValue.data(null));

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();

    final result = await signInUseCase(email: email, password: password);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return false;
      },
      (user) {
        state = AsyncValue.data(user);
        authNotifier.signIn(user);
        return true;
      },
    );
  }
}

// Sign up state providers
final signupStateProvider =
    StateNotifierProvider.autoDispose<SignupNotifier, AsyncValue<User?>>((ref) {
      final signUpUseCase = ref.watch(signUpUseCaseProvider);
      final authNotifier = ref.watch(authStateProvider.notifier);
      return SignupNotifier(
        signUpUseCase: signUpUseCase,
        authNotifier: authNotifier,
      );
    });

class SignupNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignUpUseCase signUpUseCase;
  final AuthNotifier authNotifier;

  SignupNotifier({required this.signUpUseCase, required this.authNotifier})
    : super(const AsyncValue.data(null));

  Future<bool> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    state = const AsyncValue.loading();

    final result = await signUpUseCase(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return false;
      },
      (user) {
        state = AsyncValue.data(user);
        authNotifier.signIn(user);
        return true;
      },
    );
  }
}

// For testing and development, mock providers
final mockUserProvider = Provider<User>((ref) {
  return User(
    id: 'mock-user-id',
    email: 'user@example.com',
    firstName: 'John',
    lastName: 'Doe',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    isEmailVerified: true,
  );
});

// Use case providers
// These will be replaced with actual implementations when available
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUseCase(authRepository);
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(authRepository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
});

final isAuthenticatedUseCaseProvider = Provider<IsAuthenticatedUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsAuthenticatedUseCase(authRepository);
});

// Mock repository provider
// Will be replaced with a real implementation
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});
