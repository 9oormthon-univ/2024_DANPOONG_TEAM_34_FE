import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    // Get.putAsync<AuthProvider>(
    //   () async => AuthProviderImpl(),
    // );
    // Get.lazyPut<QuizRemoteProvider>(() => QuizRemoteProviderImpl());
    // Get.lazyPut<QuizHistoryRemoteProvider>(
    //     () => QuizHistoryRemoteProviderImpl());

    // Repositories
    // Get.putAsync<AuthRepository>(
    //   () async => AuthRepositoryImpl(),
    // );

    // Get.lazyPut<QuizRepository>(() => QuizRepositoryImpl());
    // Get.lazyPut<QuizHistoryRepository>(() => QuizHistoryRepositoryImpl());
  }
}
