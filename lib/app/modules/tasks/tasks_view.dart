import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'tasks_logic.dart';

class TasksPage extends StatelessWidget {
  final logic = Get.find<TasksLogic>();

  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GetBuilder<TasksLogic>(
              id: 'student',
              builder: (_) {
                final student = _.student;
                return Column(
                  children: [
                    Center(
                      child: Text(
                          student != null
                              ? student.data['name']
                              : 'Estudiante no encontrado',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Text(
                          student != null
                              ? student.data['grade']
                              : 'Estudiante no encontrado',
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ],
                );
              }),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tareas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
           GetBuilder<TasksLogic>(
                  id: 'tasks',
                  builder: (_) {
                    final tasks = _.tasks;
                    final selectedTask = _.selectedTask;
                    return SizedBox(
                      height: 40,
                      child: tasks != null
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (__, index) {
                                final data = tasks.documents[index];
                                final date = DateTime.parse(data.data['date']);
                                final dayWeek =
                                    DateFormat('EEEE', 'es_ES').format(date);
                                final day =
                                    DateFormat('d', 'es_ES').format(date);
                                final month =
                                    DateFormat('MMMM', 'es_ES').format(date);
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: selectedTask ==
                                                  '$dayWeek $day del $month'
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              '$dayWeek $day del $month',
                                              style: TextStyle(
                                                  color: selectedTask ==
                                                          '$dayWeek $day del $month'
                                                      ? Colors.white
                                                      : Colors.blue))),
                                    ),
                                    onTap: () => logic.selectTask(data),
                                  ),
                                );
                              },
                              itemCount: tasks.documents.length)
                          : const Text('Tareas no encontradas'),
                    );
                  }),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Detalles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<TasksLogic>(
                  id: 'task',
                  builder: (_) {
                    final task = _.task;
                    if (task != null) {
                      final date = DateTime.parse(task.data['date']);
                      final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
                      final day = DateFormat('d', 'es_ES').format(date);
                      final month = DateFormat('MMMM', 'es_ES').format(date);
                      final dateE = DateTime.parse(task.data['dateEnd']);
                      final dayWeekE =
                          DateFormat('EEEE', 'es_ES').format(dateE);
                      final dayE = DateFormat('d', 'es_ES').format(dateE);
                      final monthE = DateFormat('MMMM', 'es_ES').format(dateE);
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Título: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: task.data['title']),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Descripción: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: task.data['description']),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Fecha de creación: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '$dayWeek $day del $month'),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Fecha de presentación: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '$dayWeekE $dayE del $monthE'),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'PDF: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  mouseCursor: SystemMouseCursors.click,
                                  text: 'aqui',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => logic.launchPDF(
                                        task.data['pdfURL'].toString())),
                            ])),
                          ]);
                    } else {
                      return const Text('Datos de la tarea no encontrados');
                    }
                  })),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Nota',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<TasksLogic>(
                  id: 'taskStd',
                  builder: (_) {
                    final taskStd = _.taskStd;
                    if (taskStd != null) {
                      final date = DateTime.parse(taskStd.data['date']);
                      final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
                      final day = DateFormat('d', 'es_ES').format(date);
                      final month = DateFormat('MMMM', 'es_ES').format(date);
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Criterio: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: taskStd.data['description']),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Nota: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      taskStd.data['qualification'].toString()),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  text: 'Fecha de entrega: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '$dayWeek $day del $month'),
                            ])),
                          ]);
                    } else {
                      return const Text(
                          'La tarea aun no fue enviada o calificada');
                    }
                  })),
        ],
      ),
    );
  }
}
