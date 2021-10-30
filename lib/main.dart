import 'dart:ui';

import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/data/services/dialog_service.dart';
import 'package:docente/app/routes/app_pages.dart';
import 'package:docente/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await GetStorage.init();
  await initializeDateFormatting('es_ES');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
        Get.put(DialogService());
      }),
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Docente',
      getPages: AppPages.routes,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
