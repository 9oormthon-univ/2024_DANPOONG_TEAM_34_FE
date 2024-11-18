import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';

import 'auth_provider.dart';

class AuthProviderImpl extends BaseConnect implements AuthProvider {
  @override
  Future<Map<String, dynamic>> loginWithKakaoAccessToken(
      String accessToken) async {
    final Response response;

    try {
      response = await post("/oauth/login/kakao", null,
          headers: {"Authorization": "Bearer $accessToken"});
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }
}
