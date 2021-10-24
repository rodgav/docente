import 'package:get/get.dart';

import 'new_note_logic.dart';

class NewNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewNoteLogic());
  }
}
