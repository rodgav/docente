import 'package:docente/app/data/providers/data_provider.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';

import 'encrypt_helper.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<EncryptHelper>(EncryptHelper());
    Get.put<Client>(Client()
        .setEndpoint('https://appwrite.rsgmsolutions.com/v1')
        .setProject('616c7e2d9137c')
        .setSelfSigned(status: false));

    /*Get.put<LocalAuthProvider>(LocalAuthProvider());
    Get.put<LocalAuthRepository>(LocalAuthRepository());*/
    Get.put<DataProvider>(DataProvider());
    Get.put<DataRepository>(DataRepository());
  }
}
