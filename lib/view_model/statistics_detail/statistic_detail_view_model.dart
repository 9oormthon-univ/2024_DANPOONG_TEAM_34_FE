import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/task_state.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository.dart';

class StatisticsDetailViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final _statisticsDetailRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;
  final _taskList = <TaskState>[].obs;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  PageController get pageController => _pageController;
  List<TaskState> get taskList => _taskList;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    // _statisticsDetailRepository = Get.find<>
    // Initialize private fields
    _statisticsDetailRepository = Get.find<StatisticsRepository>();
    _pageController = PageController(viewportFraction: 0.83);
    readUserTaskList();
    // 예시데이터 삽입
    // _taskList.addAll([
    //   TaskState(
    //       time: "09:00",
    //       title: "출근",
    //       description: "기상시간 9시에 맞추어서 일어났다.",
    //       imageUrl: "assets/images/wake.png"),
    //   TaskState(
    //       time: "12:10",
    //       title: "점심 식사",
    //       description: "점심은 내가 좋아하는 돈까스와 함께 오므라이스를 먹었다",
    //       imageUrl: "assets/images/lunch.png"),
    //   TaskState(
    //       time: "15:30",
    //       title: "산책",
    //       description: "밥을 먹고 산책을 나가 보았다. 숲의 색이 너무 이뻤다. 마음이 편안해 진다.",
    //       imageUrl: "assets/images/walk.png"), // 마지막 점만 있는 경우
    // ]);
  }

  void readUserTaskList() async {
    // _taskList.addAll(await _statisticsDetailRepository.readUserTaskList());
    _taskList.value = await _statisticsDetailRepository.readUserTaskList();

    // _taskList.addAll(await _statisticsDetailRepository.readUserTaskList());
  }
}
