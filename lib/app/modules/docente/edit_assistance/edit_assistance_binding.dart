import 'package:get/get.dart';

import 'edit_assistance_logic.dart';

class EditAssistanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditAssistanceLogic());
  }
}
