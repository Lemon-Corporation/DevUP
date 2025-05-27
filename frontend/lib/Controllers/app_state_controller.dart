import 'package:get/get.dart';
import '../Data/services/data_service.dart';

/// Контроллер состояния приложения на основе GetX
/// Служит единой точкой доступа к данным приложения во всех экранах
class AppStateController extends GetxController {
  // Синглтон для быстрого доступа
  static AppStateController get to => Get.find<AppStateController>();

  // Ссылка на сервис данных
  final DataService _dataService = DataService.to;
  
  // Текущий выбранный курс
  final Rx<String?> _selectedCourseId = Rx<String?>(null);
  String? get selectedCourseId => _selectedCourseId.value;
  
  // Текущий выбранный модуль
  final Rx<int> _selectedModuleIndex = 0.obs;
  int get selectedModuleIndex => _selectedModuleIndex.value;
  
  // Текущее выбранное задание
  final Rx<String?> _selectedTaskId = Rx<String?>(null);
  String? get selectedTaskId => _selectedTaskId.value;
  
  // Инициализация контроллера
  @override
  void onInit() {
    super.onInit();
    // Дополнительная инициализация, если необходимо
  }
  
  // Выбор курса
  void selectCourse(String courseId) {
    _selectedCourseId.value = courseId;
    update();
  }
  
  // Выбор модуля
  void selectModule(int moduleIndex) {
    _selectedModuleIndex.value = moduleIndex;
    update();
  }
  
  // Выбор задания
  void selectTask(String taskId) {
    _selectedTaskId.value = taskId;
    update();
  }
  
  // Получение текущего курса
  get currentCourse => _selectedCourseId.value != null 
      ? _dataService.getCourseById(_selectedCourseId.value!) 
      : null;
  
  // Получение текущего модуля
  get currentModule => currentCourse != null && _selectedModuleIndex.value < currentCourse.modules.length 
      ? currentCourse.modules[_selectedModuleIndex.value] 
      : null;
  
  // Получение текущего задания
  get currentTask => _selectedTaskId.value != null 
      ? _dataService.getTaskById(_selectedTaskId.value!) 
      : null;
  
  // Проверка, является ли задание выполненным
  bool isTaskCompleted(String courseId, String taskId) {
    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return false;
    
    return courseProgress.completedTasksIds.contains(taskId);
  }
  
  // Отметка задания как выполненного
  void markTaskAsCompleted(String courseId, String taskId, int xpReward) {
    _dataService.markTaskAsCompleted(courseId, taskId, xpReward);
    update();
  }
  
  // Получение следующего задания в текущем модуле
  String? getNextTaskId(String courseId, String currentTaskId) {
    final course = _dataService.getCourseById(courseId);
    if (course == null) return null;
    
    final currentModule = course.modules[_selectedModuleIndex.value];
    
    // Находим все задания в текущем модуле
    final List<String> taskIds = [];
    for (final lesson in currentModule.lessons) {
      if (lesson.taskId != null) {
        taskIds.add(lesson.taskId!);
      }
    }
    
    // Находим индекс текущего задания
    final currentTaskIndex = taskIds.indexOf(currentTaskId);
    if (currentTaskIndex == -1 || currentTaskIndex == taskIds.length - 1) {
      // Если текущее задание последнее в модуле или не найдено
      return null;
    }
    
    // Возвращаем следующее задание
    return taskIds[currentTaskIndex + 1];
  }
  
  // Получение процента завершения курса
  double getCourseCompletionPercentage(String courseId) {
    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return 0.0;
    
    return courseProgress.completionPercentage;
  }
  
  // Получение процента завершения модуля
  double getModuleCompletionPercentage(String courseId, int moduleIndex) {
    final course = _dataService.getCourseById(courseId);
    if (course == null) return 0.0;
    
    final courseProgress = _dataService.currentUser.coursesProgress[courseId];
    if (courseProgress == null) return 0.0;
    
    // Если индекс модуля выходит за пределы
    if (moduleIndex < 0 || moduleIndex >= course.modules.length) return 0.0;
    
    final module = course.modules[moduleIndex];
    
    // Считаем количество заданий в модуле
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