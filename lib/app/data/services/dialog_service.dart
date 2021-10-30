import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService extends GetxService {
  static DialogService get to => Get.find();

  void openDialog(){
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  void closeDialog(){
    Get.back();
  }

}