import 'package:appwrite/models.dart';
import 'package:docente/app/data/models/document_list_app.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/dialog_service.dart';
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
  final scrollController = ScrollController();
  String _selectGrade = '';
  String _selectedTask = '';
  DocumentList? _tasks;
  DocumentListApp? _taskStds;
  Document? _task;
  int _index = 0;
  final int _limit = 25;

  String get selectGrade => _selectGrade;

  String get selectedTask => _selectedTask;

  DocumentList? get tasks => _tasks;

  DocumentListApp? get taskStds => _taskStds;

  Document? get task => _task;

  @override
  void onReady() {
    _setupScrollController();
    super.onReady();
  }

  void _setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        _getTaskStudent(task!.$id, false);
      }
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        _getTaskStudent(task!.$id, true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _selectedTask = '';
    _task = null;
    _taskStds=null;
    update(['tasks', 'task','taskStds']);
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
    _getTaskStudent(document.$id, true);
  }

  void _getTaskStudent(String idTask, bool reload) async {
    if (reload) {
      _taskStds = DocumentListApp(sum: 0, documents: []);
      _index = 0;
    }
    DocumentListApp oldTaskStds;
    DocumentListApp newTaskStds;
    if (taskStds != null) {
      oldTaskStds = taskStds!;
    } else {
      oldTaskStds = DocumentListApp(sum: 0, documents: []);
    }
    if (oldTaskStds.sum >= _index) {
      final newTask = await _dataRepository.getTasksStudent(
          grade: selectGrade, idTask: idTask, index: _index, limit: _limit);
      if (newTask != null) {
        newTaskStds =
            DocumentListApp(sum: newTask.sum, documents: newTask.documents);
      } else {
        newTaskStds = DocumentListApp(sum: 0, documents: []);
      }
    } else {
      newTaskStds = DocumentListApp(sum: 0, documents: []);
    }
    _taskStds = oldTaskStds;
    _taskStds!.sum = newTaskStds.sum;
    _taskStds!.documents.addAll(newTaskStds.documents);
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
                    TextSpan(text: document.data['name']),
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
      DialogService.to.openDialog();
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
      DialogService.to.closeDialog();
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
