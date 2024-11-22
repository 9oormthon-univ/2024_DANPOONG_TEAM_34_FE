import 'package:get/get.dart';
import 'package:rebootOffice/provider/auth/auth_provider.dart';
import 'package:rebootOffice/provider/auth/auth_provider_impl.dart';
import 'package:rebootOffice/provider/chatting/chatting_provider.dart';
import 'package:rebootOffice/provider/chatting/chatting_provier_impl.dart';
import 'package:rebootOffice/provider/home/home_provider.dart';
import 'package:rebootOffice/provider/home/home_provider_impl.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider_impl.dart';
import 'package:rebootOffice/repository/auth/auth_repository.dart';
import 'package:rebootOffice/repository/auth/auth_repository_impl.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository_impl.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';
import 'package:rebootOffice/repository/home/home_repository_impl.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository_impl.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<AuthProvider>(() => AuthProviderImpl());
    Get.lazyPut<ChattingProvider>(() => ChattingProvierImpl());
    Get.lazyPut<StatisticsProvider>(() => StatisticsProviderImpl());
    Get.lazyPut<HomeProvider>(() => HomeProviderImpl());
    // Repositories

    // Repositories - Provider 초기화 후 생성
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<ChattingRepository>(() => ChattingRepositoryImpl());
    Get.lazyPut<StatisticsRepository>(() => StatisticsRepositoryImpl());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    // Get.lazyPut<QuizRepository>(() => QuizRepositoryImpl());
    // Get.lazyPut<QuizHistoryRepository>(() => QuizHistoryRepositoryImpl());
  }
}
