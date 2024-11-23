import 'package:get/get.dart';

abstract class OnBoardingRepository {
  Future<Response> sendOnBoardingData(
      String name, String nameEn, String gender, String birth, String motivate);
}
