import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'edit_quali_task_logic.dart';

class EditQualiTaskPage extends StatelessWidget {
  final logic = Get.find<EditQualiTaskLogic>();

  EditQualiTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Editar notas de tareas',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('RODOLFO SAMUEL GAVILAN MUÑOZ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          const Center(
              child: Text('docente - Computación',
                  style: TextStyle(
                    color: Colors.black,
                  ))),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Grados',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))),
          const SizedBox(height: 5),
          GetBuilder<EditQualiTaskLogic>(
              id: 'grade',
              builder: (_) {
                final grades = logic.grades;
                return SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (__, index) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: logic.selectGrade == grades[index]
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue)),
                                margin: const EdgeInsets.only(left: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(grades[index],
                                        style: TextStyle(
                                            color: logic.selectGrade ==
                                                    grades[index]
                                                ? Colors.white
                                                : Colors.blue))),
                              ),
                              onTap: () => logic.gradeSelect(grades[index]),
                            ),
                          ),
                      itemCount: grades.length),
                );
              }),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Editar notas de tareas',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
          GetBuilder<EditQualiTaskLogic>(
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
                            final day = DateFormat('d', 'es_ES').format(date);
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
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.blue)),
                                  margin: const EdgeInsets.only(left: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('$dayWeek $day del $month',
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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<EditQualiTaskLogic>(
                  id: 'task',
                  builder: (_) {
                    final task = _.task;
                    if (task != null) {
                        final date = DateTime.parse(task.data['date']);
                        final dayWeek =
                            DateFormat('EEEE', 'es_ES').format(date);
                        final day = DateFormat('d', 'es_ES').format(date);
                        final month = DateFormat('MMMM', 'es_ES').format(date);
                        final dateE = DateTime.parse(task.data['dateEnd']);
                        final dayWeekE =
                            DateFormat('EEEE', 'es_ES').format(dateE);
                        final dayE = DateFormat('d', 'es_ES').format(dateE);
                        final monthE =
                            DateFormat('MMMM', 'es_ES').format(dateE);
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Título: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: task.data['title'],
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Descripción: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: task.data['description'],
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Fecha de creación: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '$dayWeek $day del $month',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Fecha de presentación: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '$dayWeekE $dayE del $monthE',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ])),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'PDF: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
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
                'Notas',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 5),
          Expanded(
            child: GetBuilder<EditQualiTaskLogic>(
                id: 'taskStds',
                builder: (_) {
                  final taskStds = _.taskStds;

                  return taskStds != null
                      ? taskStds.documents.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (__, index) {
                                final taskStd = taskStds.documents[index];
                                final date =
                                    DateTime.parse(taskStd.data['date']);
                                final dayWeek =
                                    DateFormat('EEEE', 'es_ES').format(date);
                                final day =
                                    DateFormat('d', 'es_ES').format(date);
                                final month =
                                    DateFormat('MMMM', 'es_ES').format(date);
                                final qual = int.parse(
                                    taskStd.data['qualification'].toString());
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        qual >= 11 ? Colors.blue : Colors.red,
                                    child: Text(
                                      qual.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text(taskStd.data['name'].toString()),
                                  subtitle: Text('$dayWeek $day del $month'),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (__) => [
                                      PopupMenuItem(
                                        child: const Text('Editar'),
                                        value: taskStd,
                                      )
                                    ],
                                    onSelected: _.edit,
                                  ),
                                );
                              },
                              separatorBuilder: (__, index) => const Divider(),
                              itemCount: taskStds.documents.length)
                          : const Center(
                              child: Text('Notas de tareas no encontradas'))
                      : const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
