import 'package:get/get.dart';

import 'qualifications_logic.dart';

class QualificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QualificationsLogic());
  }
}
