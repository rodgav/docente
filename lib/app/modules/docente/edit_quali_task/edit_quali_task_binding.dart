import 'package:get/get.dart';

import 'edit_quali_task_logic.dart';

class EditQualiTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditQualiTaskLogic());
  }
}
