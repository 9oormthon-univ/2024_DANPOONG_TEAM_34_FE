abstract class AuthRepository {
  Future<bool> loginWithKakaoAccessToken(String accessToken);
  Future<void> clearTokens();
}
