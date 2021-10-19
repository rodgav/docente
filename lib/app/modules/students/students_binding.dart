import 'package:get/get.dart';

import 'students_logic.dart';

class StudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentsLogic());
  }
}
