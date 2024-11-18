abstract class AuthProvider {
  Future<Map<String, dynamic>> loginWithKakaoAccessToken(String accessToken);
}
