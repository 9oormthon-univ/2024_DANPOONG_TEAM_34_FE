import 'dart:core';
import 'dart:io';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/chatting/chatting_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class ChattingProvierImpl extends BaseConnect implements ChattingProvider {
  @override
  Future<List<dynamic>> readChattingRoomList() async {
    Response response;

    try {
      response = await get(
        '/chats',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  @override
  Future<List> readChatList(int chatId) async {
    Response response;

    try {
      response = await get(
        '/chats/$chatId',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  // @override
  // Future<Response<dynamic>> sendChatMessage(
  //     int chatId, String question, String eChatType, File? imageFile) async {
  //   final Map<String, dynamic> requestData = {
  //     'question': question,
  //     'eChatType': eChatType,
  //   };
  //
  //   if (imageFile != null) {
  //     // 파일을 base64로 인코딩
  //     List<int> imageBytes = await imageFile.readAsBytes();
  //     String base64Image = base64Encode(imageBytes);
  //
  //     // requestData에 base64 이미지 추가
  //     requestData['image'] = base64Image;
  //   }
  //
  //   try {
  //     return await post(
  //       '/chats',
  //       requestData,
  //       contentType: 'application/json',
  //     );
  //   } catch (e) {
  //     LogUtil.error('Error sending chat message: $e');
  //     rethrow;
  //   }
  // }
  //Multi-part 쪽 완전히 주석처리

  @override
  Future<Response<dynamic>> sendChatMessage(
      int chatId, String question, String eChatType, File? imageFile) async {
    // 이미지가 있을 경우에는 Multi-part로 전송하고, 없을 경우에는 JSON으로 전송
    late final FormData? formData;
    imageFile == null
        ? formData = null
        : formData = FormData(
            {
              'image': MultipartFile(
                imageFile,
                filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
                contentType: 'image/jpg',
              ),
            },
          );

    try {
      LogUtil.debug(
          'Sending chat message: \n $chatId \n$question \n$eChatType \n$formData');
      return await post(
        '/chats?eChatType=$eChatType&question=$question',
        formData,
        contentType: imageFile == null
            ? 'application/json'
            : 'multipart/form-data', // Content-Type 명시적 설정
      );
    } catch (e) {
      LogUtil.error('Error sending chat message: $e');
      rethrow;
    }
  }
}
