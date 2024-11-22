import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/chatting/chatting_provider.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

class ChattingProvierImpl extends BaseConnect implements ChattingProvider {
  //TODO-[규진] 가변값으로 연결 필요

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
    final Map<String, dynamic> requestData = {
      'question': question,
      'eChatType': eChatType,
    };

    final formData = FormData(
      {
        'createChatRequestDto': jsonEncode(requestData), // 직접 문자열로 전달
        if (imageFile != null)
          'image': MultipartFile(
            imageFile,
            filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
            contentType: 'image/jpg',
          ),
      },
    );

    try {
      return await post(
        '/chats',
        formData,
        contentType: 'multipart/form-data', // Content-Type 명시적 설정
      );
    } catch (e) {
      LogUtil.error('Error sending chat message: $e');
      rethrow;
    }
  }
}
