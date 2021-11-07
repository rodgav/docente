import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewQualiTaskLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  final formKey = GlobalKey<FormState>();
  final TextEditingController qualCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  String? _selectGrade;
  DocumentList? _tasks;
  Document? _task;
  DocumentList? _students;
  String _selectedTask = '';

  String? get selectGrade => _selectGrade;

  DocumentList? get tasks => _tasks;

  Document? get task => _task;

  DocumentList? get students => _students;

  String get selectedTask => _selectedTask;

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _getTaskG(grade);
  }

  void _getTaskG(String grade) async {
    _tasks = await _dataRepository.getTasksG(grade: grade);
    if (tasks != null) {
      final data = tasks!.documents[0];
      final date = DateTime.parse(data.data['date']);
      final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
      final day = DateFormat('d', 'es_ES').format(date);
      final month = DateFormat('MMMM', 'es_ES').format(date);
      _selectedTask = '$dayWeek $day del $month';
      update(['tasks']);
      _task = data;
      update(['task']);
      _getStusG();
    }
  }

  void selectTask(Document document) {
    final date = DateTime.parse(document.data['date']);
    final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
    final day = DateFormat('d', 'es_ES').format(date);
    final month = DateFormat('MMMM', 'es_ES').format(date);
    _selectedTask = '$dayWeek $day del $month';
    update(['tasks']);
    _task = document;
    update(['task']);
    _getStusG();
  }

  void _getStusG() async {
    _students = await _dataRepository.getStusG(grade: selectGrade ?? '');
    update(['students']);
  }

  void launchPDF(String pdfURL) async {
    await canLaunch(pdfURL)
        ? await launch(pdfURL)
        : throw 'Could not launch $pdfURL';
  }

  void toBack() {
    Get.rootDelegate.popRoute();
  }

  String? isNotQual(String? text) {
    if (text != null) {
      if (text.isNotEmpty) {
        final qual = int.parse(text);
        if (qual >= 0 && qual <= 20) {
          return null;
        }
      }
    }
    return 'Ingrese una nota valida';
  }

  String? isNotEmpty(String? text) {
    if (text != null) if (text.isNotEmpty) return null;
    return 'Ingrese datos';
  }

  void qualify(Document student) async {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 400,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const Center(
                        child: Text(
                          'Nueva Calificación',
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
                    TextSpan(text: student.data['name']),
                  ])),
                  const SizedBox(height: 20),
                  const Text(
                    'Nota',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: qualCtrl,
                    validator: (value) => isNotQual(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Nota',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Descripciòn',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    maxLines: 2,
                    controller: descCtrl,
                    validator: (value) => isNotEmpty(value),
                    decoration: InputDecoration(
                        hintText: 'Descripciòn',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                        onPressed: () =>
                            createNewQual(student.$id, student.data['name']),
                        child: const Text('Guardar')),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void createNewQual(String idStudent, String name) async {
    if (formKey.currentState!.validate()) {
      DialogService.to.openDialog();
      final result = await _dataRepository.createTaskStudent(map: {
        'idStudent': idStudent,
        'idTask': task!.$id,
        'name': name,
        'grade': selectGrade,
        'description': descCtrl.text,
        'qualification': qualCtrl.text,
        'date': DateTime.now().toString()
      });
      DialogService.to.closeDialog();
      if (result != null) {
        descCtrl.clear();
        qualCtrl.clear();
        toBack();
      } else {
        Get.snackbar('ERROR', 'Al guardar o ya tiene nota');
      }
    }
  }
}
