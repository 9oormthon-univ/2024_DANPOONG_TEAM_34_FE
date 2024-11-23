import 'package:get/get.dart';

abstract class RegisterRepository {
  Future<Response> sendRegisterData(Map<String, dynamic> registerData);
}
