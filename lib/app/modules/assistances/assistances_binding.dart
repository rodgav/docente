import 'package:get/get.dart';

import 'assistances_logic.dart';

class AssistancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AssistancesLogic>(
        () => AssistancesLogic(Get.parameters['idStudent'] ?? ''));
  }
}
