import 'package:get/get.dart';
import 'package:rebootOffice/provider/auth/auth_provider.dart';
import 'package:rebootOffice/provider/auth/auth_provider_impl.dart';
import 'package:rebootOffice/provider/chatting/chatting_provider.dart';
import 'package:rebootOffice/provider/chatting/chatting_provier_impl.dart';
import 'package:rebootOffice/provider/home/home_provider.dart';
import 'package:rebootOffice/provider/home/home_provider_impl.dart';
import 'package:rebootOffice/provider/on_boarding/on_boarding_provider.dart';
import 'package:rebootOffice/provider/on_boarding/on_boarding_provider_impl.dart';
import 'package:rebootOffice/provider/register/register_provider.dart';
import 'package:rebootOffice/provider/register/register_provider_impl.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider_impl.dart';
import 'package:rebootOffice/repository/auth/auth_repository.dart';
import 'package:rebootOffice/repository/auth/auth_repository_impl.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository_impl.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';
import 'package:rebootOffice/repository/home/home_repository_impl.dart';
import 'package:rebootOffice/repository/on_boarding/on_boarding_repository.dart';
import 'package:rebootOffice/repository/on_boarding/on_boarding_repository_impl.dart';
import 'package:rebootOffice/repository/register/register_repository.dart';
import 'package:rebootOffice/repository/register/register_repository_impl.dart';
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
    Get.lazyPut<StatisticsProvider>(() => StatisticsProviderImpl());
    Get.lazyPut<OnBoardingProvider>(() => OnBoardingProviderImpl());
    Get.lazyPut<RegisterProvider>(() => RegisterProviderImpl());
    // Repositories

    // Repositories - Provider 초기화 후 생성
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<ChattingRepository>(() => ChattingRepositoryImpl());
    Get.lazyPut<StatisticsRepository>(() => StatisticsRepositoryImpl());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    Get.lazyPut<StatisticsRepository>(() => StatisticsRepositoryImpl());
    Get.lazyPut<OnBoardingRepository>(() => OnBoardingRepositoryImpl());
    Get.lazyPut<RegisterRepository>(() => RegisterRepositoryImpl());

    // Get.lazyPut<QuizRepository>(() => QuizRepositoryImpl());
    // Get.lazyPut<QuizHistoryRepository>(() => QuizHistoryRepositoryImpl());
  }
}
