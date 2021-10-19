import 'package:get/get.dart';

import 'detail_student_logic.dart';

class DetailStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailStudentLogic());
  }
}
