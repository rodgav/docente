import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import 'students_logic.dart';

class StudentsPage extends StatelessWidget {
  final logic = Get.find<StudentsLogic>();

  StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool web = size.width > 800;
    double tileHeight = web ? 200 : 140.0;
    double tileWidth = web ? 200 : 140.0;
    double spacing = web ? 20.0 : 10.0;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*ElevatedButton(
                onPressed: logic.login, child: const Text('login')),
              ElevatedButton(
                onPressed: logic.createStudent, child: const Text('create')),*/
            const Text(
              'Buscar estudiante',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: logic.searchCtrl,
              decoration: InputDecoration(
                  hintText: 'Apellidos',
                  suffixIcon: IconButton(
                      onPressed: () => logic.search(),
                      icon: const Icon(Icons.search, color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.blue))),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GetBuilder<StudentsLogic>(
                  id: 'student',
                  builder: (_) {
                    final student = _.student;
                    return student != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                        student.data['name'].substring(0, 2)),
                                  ),
                                  title: RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'Estudiante: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: student.data['name'])
                                  ])),
                                  subtitle: RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'Grado: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: student.data['grade'])
                                  ]))),
                              const SizedBox(height: 10),
                              Expanded(
                                child: LayoutBuilder(
                                    builder: (context, constaints) {
                                  final count =
                                      constaints.maxWidth ~/ tileWidth;
                                  return GridView(
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: count,
                                            childAspectRatio:
                                                tileHeight / tileWidth,
                                            crossAxisSpacing: spacing,
                                            mainAxisSpacing: spacing),
                                    children: [
                                      GestureDetector(
                                        child: SizedBox(
                                          width: tileWidth,
                                          height: tileHeight,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                        shape:
                                                            BoxShape.circle)),
                                              ),
                                              const Text('Asistencias',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              const Text('Ver asistencias',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),
                                        onTap: () =>
                                            logic.goAssistances(student.$id),
                                      ),
                                      GestureDetector(
                                        child: SizedBox(
                                          width: tileWidth,
                                          height: tileHeight,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                        shape:
                                                            BoxShape.circle)),
                                              ),
                                              const Text('Tareas',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              const Text('Ver notas de tareas',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),
                                        onTap: () => logic.goTasks(student.$id),
                                      ),
                                      GestureDetector(
                                        child: SizedBox(
                                          width: tileWidth,
                                          height: tileHeight,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                        shape:
                                                            BoxShape.circle)),
                                              ),
                                              const Text('Calificaciones',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              const Text(
                                                  'Ver notas de examenes',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),
                                        onTap: () =>
                                            logic.goQualifications(student.$id),
                                      ),
                                    ],
                                  );
                                }),
                              )
                            ],
                          )
                        : const Center(
                            child: Text('Estudiante no encontrado'),
                          );
                  }),
            )
            /*Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => SizedBox(
                  width: web ? size.width * 0.5 : size.width,
                  child: ListTile(
                    leading: CircleAvatar(
                      child:
                          Text('Gavilan Muñoz Rodolfo Samuel'.substring(0, 2)),
                    ),
                    title: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Estudiante: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Gavilan Muñoz Rodolfo Samuel')
                    ])),
                    subtitle: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Grado: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '5to de primaria')
                    ])),
                    trailing: PopupMenuButton(
                        itemBuilder: (_) => [
                              const PopupMenuItem(
                                  child: Text('Asistencias'),
                                  value: 'Asistencias'),
                              const PopupMenuItem(
                                  child: Text('Tareas'), value: 'Tareas'),
                              const PopupMenuItem(
                                  child: Text('Calificaciones'),
                                  value: 'Calificaciones')
                            ]),
                  ),
                ),
                itemCount: 20,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
