import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();

  void goHome() {
    Get.rootDelegate.offNamed(Routes.home);
  }

  void close() async {
    final sessionId = AuthService.to.sessionId;
    if (sessionId != null) {
      await _dataRepository.accountDeleteSession(idSession: sessionId);
      await AuthService.to.logout();
      Get.rootDelegate.offNamed(Routes.login);
    }
  }
}
