import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:rebootOffice/repository/auth/auth_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class LoginViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final AuthRepository _authRepository;

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _authRepository = Get.find<AuthRepository>();
    // Initialize private fields
  }

  Future<bool> kakaoSignInAccount() async {
    String kakaoAccessToken;

    try {
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      kakaoAccessToken = token.accessToken;
    } catch (error) {
      LogUtil.error('Kakao Login Error: $error');
      return false; // 로그인 실패
    }

    LogUtil.info('Kakao Access Token: $kakaoAccessToken');
    bool result =
        await _authRepository.loginWithKakaoAccessToken(kakaoAccessToken);

    LogUtil.info('Kakao Login Result: $result');
    return result;
  }
}
