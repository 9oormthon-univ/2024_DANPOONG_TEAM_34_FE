import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/on_boarding/on_boarding_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class OnBoardingProviderImpl extends BaseConnect implements OnBoardingProvider {
  //TODO-[규진] 가변값으로 연결 필요

  //
  // @override
  // Future<Response<dynamic>> sendChatMessage(
  //     int chatId, String question, String eChatType, File? imageFile) async {
  //   final formData = FormData(
  //     {
  //       'image': MultipartFile(
  //         imageFile,
  //         filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
  //         contentType: 'image/jpg',
  //       ),
  //     },
  //   );
  //
  //   try {
  //     return await post(
  //       '/chats?eChatType=$eChatType&question=$question',
  //       formData,
  //       contentType: 'multipart/form-data', // Content-Type 명시적 설정
  //     );
  //   } catch (e) {
  //     LogUtil.error('Error sending chat message: $e');
  //     rethrow;
  //   }
  // }

  @override
  Future<Response<dynamic>> sendOnBoardingData(String name, String nameEn,
      String gender, String birth, String motivate) async {
    try {
      return await post(
        '/users/on-boarding',
        {
          'name': name,
          'nameEn': nameEn,
          'gender': gender,
          'birthday': birth,
          'motivation': motivate,
        },
      );
    } catch (e) {
      LogUtil.error('Error sending chat message: $e');
      rethrow;
    }
    throw UnimplementedError();
  }
}
