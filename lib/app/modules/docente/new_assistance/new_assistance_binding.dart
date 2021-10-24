import 'package:get/get.dart';

import 'new_assistance_logic.dart';

class NewAssistanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewAssistanceLogic());
  }
}
