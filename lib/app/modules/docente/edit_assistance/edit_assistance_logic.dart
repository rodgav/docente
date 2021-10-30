import 'package:appwrite/models.dart';
import 'package:docente/app/data/models/document_list_app.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAssistanceLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  final scrollController = ScrollController();
  String? _selectGrade;
  DocumentListApp? _assistances;
  int _index = 0;
  final int _limit = 25;

  String? get selectGrade => _selectGrade;

  DocumentListApp? get assistances => _assistances;

  @override
  void onReady() {
    _setupScrollController();
    super.onReady();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _getAssistances(true);
  }

  void _getAssistances(bool reload) async {
    if (reload) {
      _assistances = DocumentListApp(sum: 0, documents: []);
      _index = 0;
    }
    DocumentListApp oldAssistances;
    DocumentListApp newAssistances;
    if (assistances != null) {
      oldAssistances = assistances!;
    } else {
      oldAssistances = DocumentListApp(sum: 0, documents: []);
    }
    if (oldAssistances.sum >= _index) {
      final newAssis = await _dataRepository.getAssistances(
          grade: selectGrade!, index: _index, limit: _limit);
      if (newAssis != null) {
        newAssistances =
            DocumentListApp(sum: newAssis.sum, documents: newAssis.documents);
      } else {
        newAssistances = DocumentListApp(sum: 0, documents: []);
      }
      _index = _index + _limit + 1;
    } else {
      newAssistances = DocumentListApp(sum: 0, documents: []);
    }
    _assistances = oldAssistances;
    _assistances!.sum = newAssistances.sum;
    _assistances!.documents.addAll(newAssistances.documents);
    update(['assistances']);
  }

  void _setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        _getAssistances(false);
      }
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        _getAssistances(true);
      }
    });
  }

  void toBack() {
    Get.rootDelegate.popRoute();
  }

  void justify(Document document) {
    Get.dialog(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Center(
                child: Text(
                  'Justificar asistencia',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      child: const Icon(Icons.close, color: Colors.red),
                      onTap: toBack),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Estudiante: ',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(
                text: document.data['name'],
                style: const TextStyle(color: Colors.black)),
          ])),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
                onPressed: () => _justify(document),
                child: const Text('Justificar')),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }

  void _justify(Document document) async {
    DialogService.to.openDialog();
    final student =
        await _dataRepository.justifyAssistance(id: document.$id, map: {
      'idStudent': document.data['idStudent'],
      'name': document.data['name'],
      'grade': document.data['grade'],
      'assistance': 'justificado',
      'date': DateTime.now().toString()
    });
    DialogService.to.closeDialog();
    if (student != null) {
      _assistances!.documents
          .removeWhere((element) => element.$id == document.$id);
      _assistances!.documents.add(student);
      update(['assistances']);
      toBack();
    } else {
      Get.snackbar('ERROR', 'No se pudo guardar o ya tiene una asistencia');
    }
  }
}
