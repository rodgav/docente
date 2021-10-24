import 'package:get/get.dart';

import 'tasks_logic.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<TasksLogic>(() => TasksLogic(
        Get.parameters['idStudent'] ?? ''));
  }
}
