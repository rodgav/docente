import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAssistanceLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  String? _selectGrade;
  DocumentList? _assistances;

  String? get selectGrade => _selectGrade;

  DocumentList? get assistances => _assistances;

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _getAssistances();
  }

  void _getAssistances() async {
    _assistances = await _dataRepository.getAssistances(grade: selectGrade!);
    update(['assistances']);
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
                  style: TextStyle(color: Colors.black,fontSize: 24, fontWeight: FontWeight.bold),
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
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            TextSpan(text: document.data['name'],
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
    final student =
        await _dataRepository.justifyAssistance(id: document.$id, map: {
      'idStudent': document.data['idStudent'],
      'name': document.data['name'],
      'grade': document.data['grade'],
      'assistance': 'justificado',
      'date': DateTime.now().toString()
    });
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
