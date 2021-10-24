import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EditQualiTaskLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  final formKey = GlobalKey<FormState>();
  final TextEditingController qualCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  String _selectGrade = '';
  String _selectedTask = '';
  DocumentList? _tasks;
  DocumentList? _taskStds;
  Document? _task;

  String get selectGrade => _selectGrade;

  String get selectedTask => _selectedTask;

  DocumentList? get tasks => _tasks;

  DocumentList? get taskStds => _taskStds;

  Document? get task => _task;

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _getTaskG();
  }

  void _getTaskG() async {
    _tasks = await _dataRepository.getTasksG(grade: selectGrade);
    update(['tasks']);
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
    _getTaskStudent(document.$id);
  }

  void _getTaskStudent(String idTask) async {
    _taskStds = await _dataRepository.getTasksStudent(
        grade: selectGrade, idTask: idTask);
    update(['taskStds']);
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

  void edit(Document document) {
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
                          'Editar Calificación',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: document.data['name']),
                  ])),
                  const SizedBox(height: 20),
                  const Text(
                    'Nota',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        onPressed: () => _saveQuali(document),
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

  void _saveQuali(Document document) async {
    if (formKey.currentState!.validate()) {
      final result =
          await _dataRepository.updaTasksStudent(id: document.$id, map: {
        'idStudent': document.data['idStudent'],
        'idTask': task!.$id,
        'name': document.data['name'],
        'grade': selectGrade,
        'description': descCtrl.text,
        'qualification': qualCtrl.text,
        'date': DateTime.now().toString()
      });
      if (result != null) {
        descCtrl.clear();
        qualCtrl.clear();
        _taskStds!.documents
            .removeWhere((element) => element.$id == document.$id);
        _taskStds!.documents.add(result);
        update(['taskStds']);
        toBack();
      } else {
        Get.snackbar('ERROR', 'Al guardar o ya tiene nota');
      }
    }
  }
}
