import 'package:get/get.dart';

abstract class OnBoardingProvider {
  Future<Response<dynamic>> sendOnBoardingData(
      String name, String nameEn, String gender, String birth, String motivate);
}
