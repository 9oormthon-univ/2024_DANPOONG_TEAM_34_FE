import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rebootOffice/provider/token/token_provider.dart';

class TokenProviderImpl implements TokenProvider {
  TokenProviderImpl({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  final FlutterSecureStorage _flutterSecureStorage;
  String? _accessToken;
  String? _refreshToken;

  /* ------------------------------------------------------------ */
  /* ------------------------ Initialize ------------------------ */
  /* ------------------------------------------------------------ */
  // Initialize the provider
  @override
  Future<void> onInit() async {
    _accessToken = await _flutterSecureStorage.read(
      key: ULPExtension.accessToken,
    );

    _refreshToken = await _flutterSecureStorage.read(
      key: ULPExtension.refreshToken,
    );
  }

  /// Clear all tokens from local storage
  @override
  Future<void> clearTokens() async {
    await _flutterSecureStorage.delete(key: ULPExtension.accessToken);
    await _flutterSecureStorage.delete(key: ULPExtension.refreshToken);

    _accessToken = null;
    _refreshToken = null;
  }

  /* ------------------------------------------------------------ */
  /* -------------------------  Getter -------------------------- */
  /* ------------------------------------------------------------ */
  /// Get access token from local storage
  @override
  String? get accessToken => _accessToken;

  /// Get refresh token from local storage
  @override
  String? get refreshToken => _refreshToken;

  /* ------------------------------------------------------------ */
  /* -------------------------  Setter -------------------------- */
  /* ------------------------------------------------------------ */
  /// Set access token to local storage
  @override
  Future<void> setAccessToken(String accessToken) async {
    await _flutterSecureStorage.write(
      key: ULPExtension.accessToken,
      value: accessToken,
    );

    _accessToken = accessToken;
  }

  /// Set refresh token to local storage
  @override
  Future<void> setRefreshToken(String refreshToken) async {
    await _flutterSecureStorage.write(
      key: ULPExtension.refreshToken,
      value: refreshToken,
    );

    _refreshToken = refreshToken;
  }
}
