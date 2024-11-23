import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/utility/functions/enumToKorean.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/chatting_list/chatting_room_list_screen.dart';

class AIChatBubble extends StatelessWidget {
  final ChatState message;
  final bool showProfile;
  final String eChatType;
  AIChatBubble({
    super.key,
    required this.message,
    required this.showProfile,
    required this.eChatType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showProfile) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: ColorSystem.grey.shade300,
              child: enumToProfileImage(eChatType),
            ),
            const SizedBox(width: 12),
          ] else ...[
            const SizedBox(width: 52),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showProfile) ...[
                  Text(
                    '일상회복본부 ${enumToKorean(eChatType)}팀',
                    style: FontSystem.KR14R,
                  ),
                  const SizedBox(height: 4),
                ],
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        message.chatContent,
                        style: FontSystem.KR16R,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('HH:mm').format(message.createAt),
                      style: FontSystem.KR12R
                          .copyWith(color: ColorSystem.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
