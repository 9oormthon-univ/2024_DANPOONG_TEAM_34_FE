import 'package:get/get.dart';

abstract class RegisterProvider {
  Future<Response> sendRegisterData(Map<String, dynamic> registerData);
}
