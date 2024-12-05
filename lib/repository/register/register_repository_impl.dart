import 'package:get/get.dart';
import 'package:rebootOffice/provider/register/register_provider.dart';
import 'package:rebootOffice/repository/register/register_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class RegisterRepositoryImpl extends GetxService implements RegisterRepository {
  late final RegisterProvider _registerProvider;

  @override
  void onInit() {
    super.onInit();
    _registerProvider = Get.find<RegisterProvider>();
  }

  @override
  Future<Response> sendRegisterData(Map<String, dynamic> registerData) async {
    final response = await _registerProvider.sendRegisterData(registerData);
    return response;
  }
}
