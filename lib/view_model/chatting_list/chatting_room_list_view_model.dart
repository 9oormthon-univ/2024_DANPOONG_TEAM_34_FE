import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chatting_room_state.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';

class ChattingRoomListViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final ChattingRepository _chattingRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final RxList<ChattingRoomState> _chattingRoomList =
      <ChattingRoomState>[].obs;
  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  List<ChattingRoomState> get chattingRoomList => _chattingRoomList;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _chattingRepository = Get.find<ChattingRepository>();
    // Initialize private fields
  }

  @override
  void onReady() async {
    super.onReady();
    fetchChattingRoomList();
  }

  void fetchChattingRoomList() async {
    _chattingRoomList.value = await _chattingRepository.readChattingRoomList();
  }
}
