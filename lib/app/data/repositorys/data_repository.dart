import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:docente/app/data/providers/data_provider.dart';

class DataRepository {
  final _dataProvider = Get.find<DataProvider>();

  Future<User?> accountCreate(
          {required String email,
          required String password,
          required String name}) =>
      _dataProvider.accountCreate(email: email, password: password, name: name);

  Future<Session?> accountCreateSession(
          {required String email, required String password}) =>
      _dataProvider.accountCreateSession(email: email, password: password);

  Future<Session?> accountCreateAnonymous() =>
      _dataProvider.accountCreateAnonymous();

  Future<void> createStudent({required Map<dynamic, dynamic> map}) =>
      _dataProvider.createStudent(map: map);

  Future<Document> getStud({required String idStudent}) =>
      _dataProvider.getStud(idStudent: idStudent);

  Future<Document?> getStusN({required String name}) =>
      _dataProvider.getStusN(name: name);

  Future<DocumentList?> getStusG({required String grade}) =>
      _dataProvider.getStusG(grade: grade);

  Future<Document?> createAssistance({required Map<dynamic, dynamic> map}) =>
      _dataProvider.createAssistance(map: map);

  Future<DocumentList?> getAssitances({required String idStudent}) =>
      _dataProvider.getAssitances(idStudent: idStudent);

  Future<Document?> createTask(
          {required Map<dynamic, dynamic> map,
          required Uint8List uint8list,
          required String name}) =>
      _dataProvider.createTask(map: map, uint8list: uint8list, name: name);

  Future<DocumentList?> getTasks() => _dataProvider.getTasks();

  Future<DocumentList?> getTasksG({required String grade}) =>
      _dataProvider.getTasksG(grade: grade);

  Future<Document?> createTaskStudent({required Map<dynamic, dynamic> map}) =>
      _dataProvider.createTaskStudent(map: map);

  Future<Document?> getTaskStudent(
          {required String idStudent, required String idTask}) =>
      _dataProvider.getTaskStudent(idStudent: idStudent, idTask: idTask);

  Future<DocumentList?> getTasksStudent(
          {required String grade, required String idTask}) =>
      _dataProvider.getTasksStudent(grade: grade, idTask: idTask);

  Future<Document?> updaTasksStudent(
          {required String id, required Map<dynamic, dynamic> map}) =>
      _dataProvider.updaTasksStudent(id: id, map: map);

  Future<DocumentList?> getAssistances({required String grade}) =>
      _dataProvider.getAssistances(grade: grade);

  Future<Document?> justifyAssistance(
          {required String id, required Map<dynamic, dynamic> map}) =>
      _dataProvider.justifyAssistance(id: id, map: map);
}
