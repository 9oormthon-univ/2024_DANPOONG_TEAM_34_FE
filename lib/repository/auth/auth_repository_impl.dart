import 'package:get/get.dart';
import 'package:rebootOffice/app/factory/secure_storage_factory.dart';
import 'package:rebootOffice/provider/auth/auth_provider.dart';
import 'package:rebootOffice/provider/token/token_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends GetxService implements AuthRepository {
  late final AuthProvider _authProvider;
  late final TokenProvider _tokenProvider;

  @override
  void onInit() {
    super.onInit();

    _authProvider = Get.find<AuthProvider>();
    _tokenProvider = SecureStorageFactory.tokenProvider;
  }

  @override
  Future<bool> loginWithKakaoAccessToken(String accessToken) async {
    Map<String, dynamic> data;

    try {
      data = await _authProvider.loginWithKakaoAccessToken(accessToken);
      LogUtil.info(data['accessToken']);
    } catch (e) {
      return false;
    }

    await _tokenProvider.setAccessToken(data['jwtTokenDto']['accessToken']);
    await _tokenProvider.setRefreshToken(data['jwtTokenDto']['refreshToken']);

    return true;
  }

  @override
  Future<void> clearTokens() async {
    LogUtil.info('clearTokens');
    await _tokenProvider.clearTokens();
  }
}
