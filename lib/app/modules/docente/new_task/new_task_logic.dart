import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/auth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewTaskLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedHour = TimeOfDay.now();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  DocumentList? _tasks;
  String _selectGrade='';
  Uint8List? _bytes;
  String _nameFile = '';

  String get selectGrade => _selectGrade;

  DocumentList? get tasks => _tasks;

  @override
  void onReady() {
    _getTasks();
    super.onReady();
  }

  void gradeSelect(String value) {
    _selectGrade = value;
    update(['grade']);
  }

  void toBack() {
    Get.rootDelegate.popRoute();
  }

  String? isNotEmpty(String? text) {
    if (text != null) if (text.isNotEmpty) return null;
    return 'Ingrese datos';
  }

  void _getTasks() async {
    _tasks = await _dataRepository.getTasks();
    update(['tasks']);
  }

  void _filePicker() async {
    final pdfPicked = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
    if (pdfPicked != null) {
      _bytes = pdfPicked.files.single.bytes!;
      //_base64PDF = base64Encode(bytes);
      _nameFile = pdfPicked.files.single.name;
      update(['picked']);
    }
  }

  /*void _snackBar(Color color, String title, String body) {
    Get.snackbar(
      title,
      body,
      colorText: color,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
      margin: const EdgeInsets.all(15),
    );
  }*/

  void createNewTask() async {
    if (formKey.currentState!.validate()) {
      if (selectGrade != '') {
        if (AuthService.to.userId != null) {
          if (AuthService.to.userId == '616c934cf3ebb') {
            if (_bytes != null) {
              final task = await _dataRepository.createTask(map: {
                'title': titleCtrl.text,
                'description': descCtrl.text,
                'grade': selectGrade,
                'date': DateTime.now().toString(),
                'dateEnd':
                    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day} '
                        '${selectedHour.hour}:${selectedHour.minute.toString().length == 1 ? '0' + selectedHour.minute.toString() : selectedHour.minute.toString()}:00'
              }, uint8list: _bytes!, name: _nameFile);
              if (task != null) {
                titleCtrl.clear();
                descCtrl.clear();
                if (tasks != null) {
                  _tasks!.documents.add(task);
                } else {
                  _tasks = DocumentList(sum: 1, documents: [task]);
                }
                update(['tasks']);
                toBack();
              } else {
                Get.snackbar('ERROR', 'Al crear tarea');
              }
            } else {
              Get.snackbar('ERROR', 'Seleccione un archivo PDF');
            }
          } else {
            Get.snackbar(
                'ERROR', 'No tienes permisos para realizar esta acción');
          }
        } else {
          Get.snackbar('ERROR', 'No tienes permisos para realizar esta acción');
        }
      } else {
        Get.snackbar('ERROR', 'Seleccione un grado');
      }
    }
  }

  void newTask() {
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
                          'Nueva tarea',
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
                  const Text(
                    'Título',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  TextFormField(
                    controller: titleCtrl,
                    validator: (value) => isNotEmpty(value),
                    decoration: InputDecoration(
                        hintText: 'Título',
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
                  const SizedBox(height: 10),
                  const Text(
                    'Grado',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  GetBuilder<NewTaskLogic>(
                      id: 'grade',
                      builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectGrade,
                            hint: const Text('Grado'),
                            underline: const SizedBox(),
                            items: grades
                                .map((e) => DropdownMenuItem<String>(
                                    value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) => gradeSelect(value as String),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  const Text(
                    'Fecha de entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  GetBuilder<NewTaskLogic>(
                      id: 'date',
                      builder: (_) {
                        final date = _.selectedDate;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: selectDate,
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black)),
                                height: 50,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${date.year}/${date.month}/${date.day}'))),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  const Text(
                    'Hora de entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  GetBuilder<NewTaskLogic>(
                      id: 'hour',
                      builder: (_) {
                        final hour = _.selectedHour;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: selectHour,
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black)),
                                height: 50,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                        Text('${hour.hour}:${hour.minute}'))),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  const Text(
                    'Seleccione su PDF',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  GetBuilder<NewTaskLogic>(
                      id: 'picked',
                      builder: (_) {
                        final name = _._nameFile;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _filePicker,
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black)),
                                height: 50,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(name))),
                          ),
                        );
                      }),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                        onPressed: createNewTask, child: const Text('Guardar')),
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

  void selectDate() async {
    final picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(selectedDate.year + 5));
    if (picked != null) {
      selectedDate = picked;
      update(['date']);
    }
  }

  void selectHour() async {
    final picked = await showTimePicker(
        context: Get.context!, initialTime: TimeOfDay.now());
    if (picked != null) {
      selectedHour = picked;
      update(['hour']);
    }
  }

  void dialogTask(Document document) {
    final date = DateTime.parse(document.data['date']);
    final dateEnd = DateTime.parse(document.data['dateEnd']);
    final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
    final day = DateFormat('d', 'es_ES').format(date);
    final month = DateFormat('MMMM', 'es_ES').format(date);
    final year = DateFormat('y', 'es_ES').format(date);
    final hour = DateFormat('Hms', 'es_ES').format(date);
    final dayWeekE = DateFormat('EEEE', 'es_ES').format(dateEnd);
    final dayE = DateFormat('d', 'es_ES').format(dateEnd);
    final monthE = DateFormat('MMMM', 'es_ES').format(dateEnd);
    final yearE = DateFormat('y', 'es_ES').format(dateEnd);
    final hourE = DateFormat('Hms', 'es_ES').format(dateEnd);
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 400,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Detalles tarea',
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
                const Text(
                  'Tìtulo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${document.data['title']}'))),
                const SizedBox(height: 10),
                const Text(
                  'Descripciòn',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${document.data['description']}'))),
                const SizedBox(height: 10),
                const Text(
                  'Grado',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${document.data['grade']}'))),
                const SizedBox(height: 10),
                const Text(
                  'Fecha de creación',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '$dayWeek $day de $month del $year a las $hour'))),
                const SizedBox(height: 10),
                const Text(
                  'Fecha de entrega',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    height: 50,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '$dayWeekE $dayE de $monthE del $yearE a las $hourE'))),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      onPressed: toBack, child: const Text('Aceptar')),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
