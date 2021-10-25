import 'package:docente/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Ink.image(
                image: const AssetImage('assets/images/logo.png'),
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              onTap: logic.goHome,
            ),
          ),
          actions: [
            IconButton(
                onPressed: logic.close,
                icon:const Icon(Icons.close, color: Colors.red))
          ],
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Control Academico',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text('Computación',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ],
          ),
          centerTitle: true,
        ),
        body: GetRouterOutlet(
          initialRoute: Routes.students,
          key: Get.nestedKey(Routes.home),
        ));
  }
}
