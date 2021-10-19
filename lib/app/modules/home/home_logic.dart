import 'package:docente/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {

  void goHome() {
    Get.rootDelegate.offNamed(Routes.home);
  }
}
