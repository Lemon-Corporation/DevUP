import 'package:get/get.dart';

import '../Data/services/data_service.dart';

class AppStateController extends GetxController {
  static AppStateController get to => Get.find<AppStateController>();

  final DataService _dataService = DataService.to;

  final Rx<String?> _selectedCourseId = Rx<String?>(null);
  String? get selectedCourseId => _selectedCourseId.value;

  final Rx<int> _selectedModuleIndex = 0.obs;
  int get selectedModuleIndex => _selectedModuleIndex.value;

  final Rx<String?> _selectedTaskId = Rx<String?>(null);
  String? get selectedTaskId => _selectedTaskId.value;

  @override
  void onInit() {
    super.onInit();
  }

  void selectCourse(String courseId) {
    _selectedCourseId.value = courseId;
    update();
  }

  void selectModule(int moduleIndex) {
    _selectedModuleIndex.value = moduleIndex;
    update();
  }

  void selectTask(String taskId) {
    _selectedTaskId.value = taskId;
    update();
  }

  get currentCourse => _selectedCourseId.value != null
      ? _dataService.getCourseById(_selectedCourseId.value!)
      : null;

  get currentModule => currentCourse != null &&
          _selectedModuleIndex.value < currentCourse.modules.length
      ? currentCourse.modules[_selectedModuleIndex.value]
      : null;

  get currentTask => _selectedTaskId.value != null
      ? _dataService.getTaskById(_selectedTaskId.value!)
      : null;

  bool isTaskCompleted(String courseId, String taskId) {
    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return false;

    return courseProgress.completedTasksIds.contains(taskId);
  }

  void markTaskAsCompleted(String courseId, String taskId, int xpReward) {
    _dataService.markTaskAsCompleted(courseId, taskId, xpReward);
    update();
  }

  String? getNextTaskId(String courseId, String currentTaskId) {
    final course = _dataService.getCourseById(courseId);
    if (course == null) return null;

    final currentModule = course.modules[_selectedModuleIndex.value];

    final List<String> taskIds = [];
    for (final lesson in currentModule.lessons) {
      if (lesson.taskId != null) {
        taskIds.add(lesson.taskId!);
      }
    }

    final currentTaskIndex = taskIds.indexOf(currentTaskId);
    if (currentTaskIndex == -1 || currentTaskIndex == taskIds.length - 1) {
      return null;
    }

    return taskIds[currentTaskIndex + 1];
  }

  double getCourseCompletionPercentage(String courseId) {
    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return 0.0;

    return courseProgress.completionPercentage;
  }

  double getModuleCompletionPercentage(String courseId, int moduleIndex) {
    final course = _dataService.getCourseById(courseId);
    if (course == null) return 0.0;

    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return 0.0;

    if (moduleIndex < 0 || moduleIndex >= course.modules.length) return 0.0;

    final module = course.modules[moduleIndex];

    int totalTasks = 0;
    int completedTasks = 0;

    for (final lesson in module.lessons) {
      if (lesson.taskId != null) {
        totalTasks++;
        if (courseProgress.completedTasksIds.contains(lesson.taskId)) {
          completedTasks++;
        }
      }
    }

    if (totalTasks == 0) return 0.0;

    return completedTasks / totalTasks;
  }
}
