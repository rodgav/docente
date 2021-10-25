import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_assistance_logic.dart';

class NewAssistancePage extends StatelessWidget {
  final logic = Get.find<NewAssistanceLogic>();

  NewAssistancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ const Center(
          child: Text('Llamando lista',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        ),
          const SizedBox(height: 20),
          const Center(
            child: Text('RODOLFO SAMUEL GAVILAN MUÑOZ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const Center(
              child: Text('docente - Computación', style: TextStyle())),
          const Divider(),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Grados',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(height: 5),
          GetBuilder<NewAssistanceLogic>(
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
              child: Text('Estudiantes',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(height: 5),
          GetBuilder<NewAssistanceLogic>(
              id: 'students',
              builder: (_) {
                final students = _.students;
                return Expanded(
                  child: students != null
                      ? ListView.separated(
                          itemBuilder: (_, index) => ListTile(
                              leading: CircleAvatar(
                                child: Text(students
                                    .documents[index].data['num']
                                    .toString()),
                              ),
                              title: Text(
                                  students.documents[index].data['name']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          logic.createAssitance(
                                              students.documents[index],
                                              'falto'),
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          logic.createAssitance(
                                              students.documents[index],
                                              'justificado'),
                                      icon: const Icon(
                                        Icons.lock_clock,
                                        color: Colors.orange,
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          logic.createAssitance(
                                              students.documents[index],
                                              'presente'),
                                      icon: const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )),
                                ],
                              )),
                          separatorBuilder: (_, index) => const Divider(),
                          itemCount: students.documents.length)
                      : const Center(
                          child: Text('Estudiante no encontrado'),
                        ),
                );
              })
        ],
      ),
    );
  }
}
