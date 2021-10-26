import 'package:get/get.dart';

import 'tasks_logic.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TasksLogic(Get.parameters['idStudent'] ?? ''));
  }
}
