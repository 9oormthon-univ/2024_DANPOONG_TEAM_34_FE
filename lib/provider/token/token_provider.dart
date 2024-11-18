abstract class TokenProvider {
  /* ------------------------------------------------------------ */
  /* ------------------------ Initialize ------------------------ */
  /* ------------------------------------------------------------ */
  Future<void> onInit();
  Future<void> clearTokens();

  /* ------------------------------------------------------------ */
  /* -------------------------  Getter -------------------------- */
  /* ------------------------------------------------------------ */
  String? get accessToken;
  String? get refreshToken;

  /* ------------------------------------------------------------ */
  /* -------------------------  Setter -------------------------- */
  /* ------------------------------------------------------------ */
  Future<void> setAccessToken(String accessToken);
  Future<void> setRefreshToken(String refreshToken);
}

extension ULPExtension on TokenProvider {
  static const String accessToken = "access_token";
  static const String refreshToken = "refresh_token";
}
