import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:docente/utils/encrypt_helper.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final _encryptHelper = Get.find<EncryptHelper>();
  final _getStorage = GetStorage();

  bool get isLoggedIn => _getStorage.read('login') ?? false;

  String? get userId =>
      _encryptHelper.decrypt(_getStorage.read('userId') ?? '');

  String? get sessionId =>
      _encryptHelper.decrypt(_getStorage.read('sessionId') ?? '');

  Future<void> login(String userId, String sessionId) async {
    try {
      await _getStorage.write('userId', _encryptHelper.encrypt(userId));
      await _getStorage.write('sessionId', _encryptHelper.encrypt(sessionId));
      await _getStorage.write('login', true);
    } catch (e) {
      debugPrint('AuthService ocurrio un error $e');
    }
  }

  Future<void> logout() async {
    await _getStorage.erase();
  }
}
