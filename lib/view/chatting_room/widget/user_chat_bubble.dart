import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class UserChatBubble extends StatelessWidget {
  final ChatState message;

  const UserChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //이미지가 있을 경우 이미지를 보여줌
                message.imageUrl != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: message.imageUrl!.contains('image_picker')
                              ? Image.file(
                                  File(message.imageUrl!),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  message.imageUrl!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )
                    : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(message.createAt),
                      style: FontSystem.KR12R
                          .copyWith(color: ColorSystem.grey.shade600),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      // Flexible로 감싸서 유연한 크기 조절
                      child: ConstrainedBox(
                        // 최대 너비 제한
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.6,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0066FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message.chatContent,
                            style:
                                FontSystem.KR16R.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
