import 'package:get/get.dart';

import 'new_task_logic.dart';

class NewTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewTaskLogic());
  }
}
