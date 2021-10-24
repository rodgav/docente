import 'package:get/get.dart';

import 'new_quali_note_logic.dart';

class NewQualiNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewQualiNoteLogic());
  }
}
