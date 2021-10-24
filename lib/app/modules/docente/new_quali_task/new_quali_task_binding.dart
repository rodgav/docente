import 'package:get/get.dart';

import 'new_quali_task_logic.dart';

class NewQualiTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewQualiTaskLogic());
  }
}
