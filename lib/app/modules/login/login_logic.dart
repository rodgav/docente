import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value ?? '')) ? 'Ingrese su correo' : null;
  }

  String? isNotEmpty(String? text) {
    if (text != null) if (text.isNotEmpty) return null;
    return 'Ingrese su contraseña';
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      if (!AuthService.to.isLoggedIn) {
        final session = await _dataRepository.accountCreateSession(
          //email: 'bankenro.myhope@gmail.com', password: '31en02fe24ma');
            email: emailCtrl.text.trim(),
            password: passCtrl.text.trim());
        if (session != null) {
          AuthService.to.login(session.userId);
          Get.rootDelegate.offNamed(Routes.home);
        }
      } else {
        Get.rootDelegate.offNamed(Routes.home);
      }
    }
  }

  void loginA() async {
    if (!AuthService.to.isLoggedIn) {
      final session = await _dataRepository.accountCreateAnonymous();
      if (session != null) {
        AuthService.to.login(session.userId);
        Get.rootDelegate.offNamed(Routes.home);
      }
    } else {
      Get.rootDelegate.offNamed(Routes.home);
    }
  }
}