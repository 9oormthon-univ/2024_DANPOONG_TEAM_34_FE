import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_room_list_view_model.dart';

class ChattingRoomViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final ChattingRepository _chattingRepository;
  late final ChattingRoomListViewModel _chattingRoomListViewModel;

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  final RxString _selectedChatType = 'LUNCH'.obs;
  late final _messageController = TextEditingController();
  late final RxList<ChatState> _chatList = <ChatState>[].obs;

  late final RxBool _hasImage = false.obs;
  late final Rx<File?> _imageFile = Rx<File?>(null);
  late final TextEditingController _contentController = TextEditingController();
  late final ImagePicker _picker = ImagePicker();
  late final RxInt _chatRoomId = 0.obs;

  // 스크롤 컨트롤러 및 로딩 상태
  final ScrollController scrollController = ScrollController();
  final RxBool _isLoading = false.obs;
  final RxBool _showSuccessAnimation = false.obs;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */

  TextEditingController get messageController => _messageController;
  List<ChatState> get chatList => _chatList;

  bool get hasImage => _hasImage.value;
  File? get imageFile => _imageFile.value;
  TextEditingController get contentController => _contentController;
  ImagePicker get picker => _picker;
  String get selectedChatType => _selectedChatType.value;
  bool get isLoading => _isLoading.value;
  bool get showSuccessAnimation => _showSuccessAnimation.value;

  int get chatRoomId => _chatRoomId.value;
  set selectedChatType(String value) => _selectedChatType.value = value;
  set setChatRoomId(int value) => _chatRoomId.value = value;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _chattingRepository = Get.find<ChattingRepository>();
    // Initialize private fields
    _chattingRoomListViewModel = Get.find<ChattingRoomListViewModel>();
  }

  void setIsLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> fetchChatList(int chatId) async {
    _chatList.value = await _chattingRepository.readChatList(chatId);
    _chatRoomId.value = chatId;
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> sendMessage(int chatId) async {
    if (_contentController.text.trim().isEmpty) return;

    try {
      // 사용자 메시지 생성
      final userMessage = ChatState(
        chatContent: _contentController.text,
        imageUrl: _imageFile.value?.path, // 로컬 이미지 경로
        createAt: DateTime.now(),
        speaker: "USER",
      );

      // 먼저 사용자 메시지를 리스트에 추가
      _chatList.add(userMessage);
      scrollToBottom();
      setIsLoading(true);
      // API 호출
      final response = await _chattingRepository.sendChatMessage(
        chatId,
        _contentController.text,
        _selectedChatType.value,
        _imageFile.value,
      );

      if (response.body['data']['isCompleted'] == true) {
        _showAndHideSuccessAnimation();
        LogUtil.info('메시지 전송 성공');
      }

      // AI 응답 메시지 생성
      final aiMessage = ChatState(
          chatContent: response.body['data']['chatContent'],
          imageUrl: null,
          createAt: DateTime.now(),
          speaker: "AI");
      // AI 응답을 리스트에 추가
      _chatList.add(aiMessage);

      setIsLoading(false);
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollToBottom();
      });
      // 입력 필드 및 이미지 초기화
      _contentController.clear();
      _imageFile.value = null;
      _hasImage.value = false;
      _chatRoomId.value = 0;

      //다 했으면 채팅 불러오기 보고 안 하면 안 줄어듬 애초에
      _chattingRoomListViewModel.fetchChattingRoomList();
    } catch (e) {
      // 에러 발생 시 마지막 메시지 제거 (사용자 메시지 롤백)
      // if (_chatList.isNotEmpty) {
      //   _chatList.removeLast();
      // }
      LogUtil.error(e);
    }
  }

  void _showAndHideSuccessAnimation() {
    _showSuccessAnimation.value = true;
    Future.delayed(const Duration(milliseconds: 3500), () {
      _showSuccessAnimation.value = false;
    });
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
