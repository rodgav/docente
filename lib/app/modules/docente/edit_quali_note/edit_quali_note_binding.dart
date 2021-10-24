import 'package:get/get.dart';

import 'edit_quali_note_logic.dart';

class EditQualiNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditQualiNoteLogic());
  }
}
