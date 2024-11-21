import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';

class ChattingRoomViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;

  late final RxBool _isLoadingWhenOpenDialog;

  late final _messageController = TextEditingController();
  late final _messages = <ChatMessage>[].obs;

  late final RxBool _hasImage = false.obs;
  late final Rx<File?> _imageFile = Rx<File?>(null);
  late final TextEditingController _contentController = TextEditingController();
  late final ImagePicker _picker = ImagePicker();

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  PageController get pageController => _pageController;

  bool get isLoadingWhenOpenDialog => _isLoadingWhenOpenDialog.value;

  TextEditingController get messageController => _messageController;
  List<ChatMessage> get messages => _messages;

  bool get hasImage => _hasImage.value;
  File? get imageFile => _imageFile.value;
  TextEditingController get contentController => _contentController;
  ImagePicker get picker => _picker;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // Initialize private fields
    _pageController = PageController(viewportFraction: 0.83);

    _isLoadingWhenOpenDialog = false.obs;
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add(
      ChatMessage(
        sender: '규진 인턴',
        content: messageController.text,
        time: DateFormat('HH:mm').format(DateTime.now()),
      ),
    );

    messageController.clear();
  }

  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (photo != null) {
        // setter 대신 .value로 직접 접근
        _imageFile.value = File(photo.path);
        _hasImage.value = true;
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  Future<void> checkAndRequestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      takePhoto();
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        takePhoto();
      } else {
        _showPermissionDialog();
      }
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('권한 설정'),
        content: const Text('카메라 사용을 위해 설정에서 권한을 허용해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('설정으로 이동'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
