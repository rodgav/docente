import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_assistance_logic.dart';

class NewAssistancePage extends StatelessWidget {
  final logic = Get.find<NewAssistanceLogic>();

  NewAssistancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('RODOLFO SAMUEL GAVILAN MUÑOZ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          GetBuilder<NewAssistanceLogic>(
              id: 'grade',
              builder: (_) {
                return SizedBox(
                  width: size.width * 0.5,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: logic.selectGrade,
                    hint: const Text('Grados'),
                    items: logic.grades
                        .map((e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => logic.gradeSelect(value as String),
                  ),
                );
              }),
          const SizedBox(height: 20),
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
                              title:
                                  Text(students.documents[index].data['name']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () => logic.createAssitance(
                                          students.documents[index],
                                          'falto'),
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () => logic.createAssitance(
                                          students.documents[index],
                                          'justificado'),
                                      icon: const Icon(
                                        Icons.lock_clock,
                                        color: Colors.orange,
                                      )),
                                  IconButton(
                                      onPressed: () => logic.createAssitance(
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
