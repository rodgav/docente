import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_logic.dart';

class RootPage extends StatelessWidget {
  final logic = Get.find<RootLogic>();

  RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      debugPrint('title ${current?.location}');
      return Scaffold(
          body: GetRouterOutlet(
              initialRoute:
                  AuthService.to.isLoggedIn ? Routes.home : Routes.login));
    });
  }
}
