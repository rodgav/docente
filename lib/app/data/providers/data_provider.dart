import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;

class DataProvider {
  final _client = g.Get.find<Client>();

  Future<User?> accountCreate(
      {required String email,
      required String password,
      required String name}) async {
    Account account = Account(_client);
    try {
      final user =
          await account.create(email: email, password: password, name: name);
      debugPrint('user $user');
      return user;
    } catch (e) {
      debugPrint('e $e');
      return null;
    }
  }

  Future<Session?> accountCreateSession(
      {required String email, required String password}) async {
    Account account = Account(_client);
    try {
      final session =
          await account.createSession(email: email, password: password);
      debugPrint('session $session');
      return session;
    } catch (e) {
      debugPrint('e $e');
      return null;
    }
  }

  Future<Session?> accountCreateAnonymous() async {
    Account account = Account(_client);
    try {
      final session = await account.createAnonymousSession();
      debugPrint('session $session');
      debugPrint('session ${session.userId}');
      return session;
    } catch (e) {
      debugPrint('e $e');
      return null;
    }
  }

  Future<void> createStudent({required Map<dynamic, dynamic> map}) async {
    final database = Database(_client);
    final result = await database
        .createDocument(collectionId: '616c92d8b4b26', data: map, read: ['*']);
    debugPrint('result ${result.data}');
  }

  Future<Document> getStud({required String idStudent}) async {
    final database = Database(_client);
    final result = await database.getDocument(
        collectionId: '616c92d8b4b26', documentId: idStudent);
    return result;
  }

  Future<Document?> getStusN({required String name}) async {
    final database = Database(_client);
    final result = await database
        .listDocuments(collectionId: '616c92d8b4b26', filters: ['name=$name']);
    if (result.documents.isNotEmpty) {
      return result.documents[0];
    }
    return null;
  }

  Future<DocumentList?> getStusG({required String grade}) async {
    final database = Database(_client);
    final result = await database.listDocuments(
        collectionId: '616c92d8b4b26',
        filters: ['grade=$grade'],
        orderField: 'num',
        orderCast: 'int',
        orderType: 'ASC',
        limit: 50);
    if (result.documents.isNotEmpty) {
      return result;
    }
    return null;
  }

  Future<Document> createAssistance(
      {required Map<dynamic, dynamic> map}) async {
    final database = Database(_client);
    final result = await database
        .createDocument(collectionId: '616cc4d112dc3', data: map, read: ['*']);
    return result;
  }

  Future<DocumentList?> getAssitances({required String idStudent}) async {
    final database = Database(_client);
    final result = await database.listDocuments(
        collectionId: '616cc4d112dc3',
        filters: ['idStudent=$idStudent'],
        orderField: 'date',
        orderCast: 'date',
        orderType: 'DESC');
    if (result.documents.isNotEmpty) {
      return result;
    }
    return null;
  }

  Future<Document?> createTask(
      {required Map<dynamic, dynamic> map,
      required Uint8List uint8list,
      required String name}) async {
    try {
      final database = Database(_client);
      final imageId = await _saveFile(uint8list: uint8list, name: name);
      if (imageId != null) {
        map.addAll({
          'imageUrl':
              'http://appwrite.rsgmsolutions.com/v1/storage/files/$imageId/view?project=616c7e2d9137c'
        });
        final result = await database.createDocument(
            collectionId: '616f7199879d8', data: map, read: ['*']);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> _saveFile(
      {required Uint8List uint8list, required String name}) async {
    try {
      Storage storage = Storage(_client);
      final response = await storage.createFile(
          file: MultipartFile.fromBytes('file', uint8list, filename: name),
          read: ['*']);
      return response.$id;
    } catch (e) {
      return null;
    }
  }

  Future<DocumentList?> getTasks() async {
    final database = Database(_client);
    final result = await database.listDocuments(
        collectionId: '616f7199879d8',
        orderField: 'date',
        orderCast: 'date',
        orderType: 'ASC');
    if (result.documents.isNotEmpty) {
      return result;
    }
    return null;
  }

  Future<DocumentList?> getTasksG({required String grade}) async {
    final database = Database(_client);
    final result = await database.listDocuments(
        collectionId: '616f7199879d8',
        filters: ['grade=$grade'],
        orderField: 'date',
        orderCast: 'date',
        orderType: 'ASC');
    if (result.documents.isNotEmpty) {
      return result;
    }
    return null;
  }
}
