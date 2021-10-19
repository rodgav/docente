import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assistances_logic.dart';

class AssistancesPage extends StatelessWidget {
  final logic = Get.find<AssistancesLogic>();

  AssistancesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          GetBuilder<AssistancesLogic>(
              id: 'student',
              builder: (_) {
                final student = _.student;
                return Column(
                  children: [
                    Text(
                        student != null
                            ? student.data['name']
                            : 'Estudiante no encontrado',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(
                        student != null
                            ? student.data['grade']
                            : 'Estudiante no encontrado',
                        style: const TextStyle(fontSize: 20)),
                  ],
                );
              }),
          const SizedBox(height: 20),
          GetBuilder<AssistancesLogic>(
              id: 'assistances',
              builder: (_) {
                final assistances = _.assistances;
                return Expanded(
                  child: assistances != null
                      ? ListView.separated(
                          itemBuilder: (_, index) {
                            final data = assistances.documents[index].data;
                            return ListTile(
                              title: Text(
                                data['assistance'],
                                style: TextStyle(
                                    color: data['assistance'] == 'presente'
                                        ? Colors.green
                                        : data['assistance'] == 'justificado'
                                            ? Colors.orange
                                            : Colors.red),
                              ),
                              subtitle: Text(data['date']),
                            );
                          },
                          separatorBuilder: (_, index) => const Divider(),
                          itemCount: assistances.documents.length)
                      : const Center(
                          child: Text('Asistencias no encontradas'),
                        ),
                );
              })
        ],
      ),
    );
  }
}
