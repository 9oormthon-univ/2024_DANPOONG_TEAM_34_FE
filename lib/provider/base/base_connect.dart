import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/connect.dart';
import 'package:rebootOffice/app/factory/secure_storage_factory.dart';
import 'package:rebootOffice/provider/token/token_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

abstract class BaseConnect extends GetConnect {
  final TokenProvider tokenProvider = SecureStorageFactory.tokenProvider;

  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = dotenv.env['SERVER_HOST']
      ..timeout = const Duration(seconds: 30)
      ..addRequestModifier<dynamic>((request) {
        if (tokenProvider.accessToken != null) {
          request.headers['Authorization'] =
              'Bearer ${tokenProvider.accessToken}';
        }

        LogUtil.info(
          "🛫 [${request.method}] ${request.url}",
        );

        return request;
      })
      ..addResponseModifier((request, Response response) {
        if (response.status.hasError) {
          LogUtil.error(
            "🚨 [${request.method}] ${request.url} | FAILED (${response.body['error']['code']}, ${response.body['error']['message']})",
          );
        } else {
          LogUtil.info(
            "🛬 [${request.method}] ${request.url} | SUCCESS (${response.statusCode})",
          );
          LogUtil.info(
            "🛬 [${request.method}] ${request.url} | BODY ${response.body}",
          );
        }
        return response;
      });
  }
}
