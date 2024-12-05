import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/register/register_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class RegisterProviderImpl extends BaseConnect implements RegisterProvider {
  @override
  Future<Response> sendRegisterData(Map<String, dynamic> registerData) async {
    try {
      final response = await post('/users/register', registerData);
      return response;
    } catch (e) {
      LogUtil.error('Error sending register data: $e');
      rethrow;
    }
  }
}
