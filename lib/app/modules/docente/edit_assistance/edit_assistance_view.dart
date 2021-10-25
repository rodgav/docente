import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_assistance_logic.dart';

class EditAssistancePage extends StatelessWidget {
  final logic = Get.find<EditAssistanceLogic>();

  EditAssistancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Editar lista',
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
          GetBuilder<EditAssistanceLogic>(
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
          GetBuilder<EditAssistanceLogic>(
              id: 'assistances',
              builder: (_) {
                final assistances = _.assistances;
                return Expanded(
                  child: assistances != null
                      ? ListView.separated(
                          itemBuilder: (__, index) {
                            final assitance = assistances.documents[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    assitance.data['assistance'] == 'presente'
                                        ? Colors.green
                                        : assitance.data['assistance'] ==
                                                'justificado'
                                            ? Colors.orange
                                            : Colors.red,
                              ),
                              title: Text(assitance.data['name']),
                              subtitle: Text(assitance.data['date']),
                              trailing: PopupMenuButton(
                                  itemBuilder: (__) => [
                                        PopupMenuItem(
                                            child: const Text('Justificar'),
                                            value: assitance)
                                      ],onSelected: _.justify,),
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
