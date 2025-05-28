import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:customer_app/domain/entities/application.dart';
import 'package:customer_app/domain/usecases/application_usecases.dart';
import 'package:customer_app/di/dependency_injection.dart';

// Application list provider
final applicationListProvider = FutureProvider<List<Application>>((ref) {
  final getApplicationsUseCase = ref.watch(getApplicationsUseCaseProvider);

  return getApplicationsUseCase().then(
    (result) => result.fold((failure) => [], (applications) => applications),
  );
});

// Application detail provider
final applicationDetailProvider = FutureProvider.family<Application?, String>((
  ref,
  id,
) {
  if (id.isEmpty) return null;

  final getApplicationUseCase = ref.watch(getApplicationUseCaseProvider);

  return getApplicationUseCase(id).then(
    (result) => result.fold((failure) => null, (application) => application),
  );
});

// Application state
class ApplicationState {
  final bool isLoading;
  final String? error;
  final Application? application;

  ApplicationState({this.isLoading = false, this.error, this.application});

  ApplicationState copyWith({
    bool? isLoading,
    String? error,
    Application? application,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      application: application ?? this.application,
    );
  }
}

// Create application state provider
final createApplicationStateProvider =
    StateNotifierProvider.autoDispose<
      CreateApplicationNotifier,
      ApplicationState
    >((ref) {
      final createApplicationUseCase = ref.watch(
        createApplicationUseCaseProvider,
      );
      return CreateApplicationNotifier(createApplicationUseCase);
    });

class CreateApplicationNotifier extends StateNotifier<ApplicationState> {
  final CreateApplicationUseCase createApplicationUseCase;

  CreateApplicationNotifier(this.createApplicationUseCase)
    : super(ApplicationState());

  Future<bool> createApplication(String programId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await createApplicationUseCase(programId: programId);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (application) {
        state = state.copyWith(
          isLoading: false,
          application: application,
          error: null,
        );
        return true;
      },
    );
  }
}

// Upload document state provider
final uploadDocumentStateProvider =
    StateNotifierProvider.autoDispose<UploadDocumentNotifier, ApplicationState>(
      (ref) {
        final uploadDocumentUseCase = ref.watch(
          uploadApplicationDocumentUseCaseProvider,
        );
        return UploadDocumentNotifier(uploadDocumentUseCase, ref);
      },
    );

class UploadDocumentNotifier extends StateNotifier<ApplicationState> {
  final UploadApplicationDocumentUseCase uploadDocumentUseCase;
  final Ref ref;

  UploadDocumentNotifier(this.uploadDocumentUseCase, this.ref)
    : super(ApplicationState());

  Future<bool> uploadDocument({
    required String applicationId,
    required String documentId,
    required String filePath,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final docResult = await uploadDocumentUseCase(
      applicationId: applicationId,
      documentId: documentId,
      filePath: filePath,
    );

    return docResult.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (document) {
        state = state.copyWith(isLoading: false, error: null);

        // Invalidate the application detail to trigger a refresh
        ref.invalidate(applicationDetailProvider(applicationId));

        return true;
      },
    );
  }
}

// Complete task state provider
final completeTaskStateProvider =
    StateNotifierProvider.autoDispose<CompleteTaskNotifier, ApplicationState>((
      ref,
    ) {
      final completeTaskUseCase = ref.watch(
        completeApplicationTaskUseCaseProvider,
      );
      return CompleteTaskNotifier(completeTaskUseCase, ref);
    });

class CompleteTaskNotifier extends StateNotifier<ApplicationState> {
  final CompleteApplicationTaskUseCase completeTaskUseCase;
  final Ref ref;

  CompleteTaskNotifier(this.completeTaskUseCase, this.ref)
    : super(ApplicationState());

  Future<bool> completeTask({
    required String applicationId,
    required String taskId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await completeTaskUseCase(
      applicationId: applicationId,
      taskId: taskId,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (task) {
        state = state.copyWith(isLoading: false, error: null);

        // Invalidate the application detail to trigger a refresh
        ref.invalidate(applicationDetailProvider(applicationId));

        return true;
      },
    );
  }
}

// Update application status state provider
final updateApplicationStatusStateProvider =
    StateNotifierProvider.autoDispose<
      UpdateApplicationStatusNotifier,
      ApplicationState
    >((ref) {
      final updateStatusUseCase = ref.watch(
        updateApplicationStatusUseCaseProvider,
      );
      return UpdateApplicationStatusNotifier(updateStatusUseCase, ref);
    });

class UpdateApplicationStatusNotifier extends StateNotifier<ApplicationState> {
  final UpdateApplicationStatusUseCase updateStatusUseCase;
  final Ref ref;

  UpdateApplicationStatusNotifier(this.updateStatusUseCase, this.ref)
    : super(ApplicationState());

  Future<bool> updateStatus({
    required String id,
    required ApplicationStatus status,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await updateStatusUseCase(id: id, status: status);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (application) {
        state = state.copyWith(
          isLoading: false,
          application: application,
          error: null,
        );

        // Invalidate the application list and detail providers to trigger a refresh
        ref.invalidate(applicationListProvider);
        ref.invalidate(applicationDetailProvider(id));

        return true;
      },
    );
  }
}

// Mock providers for development and testing
final mockApplicationsProvider = Provider<List<Application>>((ref) {
  final now = DateTime.now();

  return [
    Application(
      id: '1',
      programId: '101',
      programName: 'Computer Science (MSc)',
      universityId: '1',
      universityName: 'Harvard University',
      status: ApplicationStatus.underReview,
      submissionDate: now.subtract(const Duration(days: 30)),
      documents: [
        ApplicationDocument(
          id: '1',
          name: 'Academic Transcripts',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/transcripts.pdf',
          submissionDate: now.subtract(const Duration(days: 28)),
        ),
        ApplicationDocument(
          id: '2',
          name: 'Statement of Purpose',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/sop.pdf',
          submissionDate: now.subtract(const Duration(days: 25)),
        ),
      ],
      timeline: [
        ApplicationTimeline(
          status: ApplicationStatus.draft,
          date: now.subtract(const Duration(days: 35)),
          description: 'Application created',
        ),
        ApplicationTimeline(
          status: ApplicationStatus.submitted,
          date: now.subtract(const Duration(days: 30)),
          description: 'Application submitted',
        ),
      ],
      tasks: [
        ApplicationTask(
          id: '1',
          title: 'Complete Application Form',
          description: 'Fill out all required fields in the application form',
          dueDate: now.subtract(const Duration(days: 31)),
          isCompleted: true,
        ),
        ApplicationTask(
          id: '2',
          title: 'Prepare for Interview',
          description: 'A video interview will be scheduled soon',
          dueDate: now.add(const Duration(days: 10)),
          isCompleted: false,
        ),
      ],
    ),
    Application(
      id: '2',
      programId: '201',
      programName: 'Electrical Engineering (PhD)',
      universityId: '2',
      universityName: 'Massachusetts Institute of Technology',
      status: ApplicationStatus.documentRequired,
      submissionDate: now.subtract(const Duration(days: 20)),
      documents: [
        ApplicationDocument(
          id: '1',
          name: 'Academic Transcripts',
          status: DocumentStatus.verified,
          fileUrl: 'https://example.com/transcripts.pdf',
          submissionDate: now.subtract(const Duration(days: 18)),
        ),
        ApplicationDocument(
          id: '2',
          name: 'Research Proposal',
          status: DocumentStatus.required,
          fileUrl: null,
          submissionDate: null,
        ),
      ],
      timeline: [
        ApplicationTimeline(
          status: ApplicationStatus.draft,
          date: now.subtract(const Duration(days: 25)),
          description: 'Application created',
        ),
        ApplicationTimeline(
          status: ApplicationStatus.submitted,
          date: now.subtract(const Duration(days: 20)),
          description: 'Application submitted',
        ),
      ],
      tasks: [
        ApplicationTask(
          id: '1',
          title: 'Submit Research Proposal',
          description: 'Prepare and upload your research proposal',
          dueDate: now.add(const Duration(days: 5)),
          isCompleted: false,
        ),
      ],
    ),
  ];
});

// Use case providers
final getApplicationsUseCaseProvider = Provider<GetApplicationsUseCase>((ref) {
  final repository = ref.watch(applicationRepositoryProvider);
  return GetApplicationsUseCase(repository);
});

final getApplicationUseCaseProvider = Provider<GetApplicationUseCase>((ref) {
  final repository = ref.watch(applicationRepositoryProvider);
  return GetApplicationUseCase(repository);
});

final createApplicationUseCaseProvider = Provider<CreateApplicationUseCase>((
  ref,
) {
  final repository = ref.watch(applicationRepositoryProvider);
  return CreateApplicationUseCase(repository);
});

final updateApplicationStatusUseCaseProvider =
    Provider<UpdateApplicationStatusUseCase>((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return UpdateApplicationStatusUseCase(repository);
    });

final uploadApplicationDocumentUseCaseProvider =
    Provider<UploadApplicationDocumentUseCase>((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return UploadApplicationDocumentUseCase(repository);
    });

final completeApplicationTaskUseCaseProvider =
    Provider<CompleteApplicationTaskUseCase>((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return CompleteApplicationTaskUseCase(repository);
    });
