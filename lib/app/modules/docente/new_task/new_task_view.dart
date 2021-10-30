
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'new_task_logic.dart';

class NewTaskPage extends StatelessWidget {
  final logic = Get.find<NewTaskLogic>();

  NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool web = size.width > 800;
    double tileHeight = web ? 200 : 140.0;
    double tileWidth = web ? 200 : 140.0;
    double spacing = web ? 20.0 : 10.0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tareas',
                    style:
                        TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                    onPressed: logic.newTask,
                    icon: const Icon(Icons.add),
                    label: const Text('Nueva tarea'))
              ],
            ),
            const SizedBox(),
            const Divider(),
            const SizedBox(height: 10),
            GetBuilder<NewTaskLogic>(
                id: 'tasks',
                builder: (_) {
                  final tasks = _.tasks;
                  return Expanded(
                    child: tasks != null
                        ? LayoutBuilder(builder: (context, constaints) {
                            final count = constaints.maxWidth ~/ tileWidth;
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: count,
                                      childAspectRatio: tileHeight / tileWidth,
                                      crossAxisSpacing: spacing,
                                      mainAxisSpacing: spacing),
                              itemBuilder: (BuildContext context, int index) {
                                final date = DateTime.parse(
                                    tasks.documents[index].data['date']);
                                final dayWeek =
                                    DateFormat('EEEE', 'es_ES').format(date);
                                final day =
                                    DateFormat('d', 'es_ES').format(date);
                                final month =
                                    DateFormat('MMMM', 'es_ES').format(date);
                                final year =
                                    DateFormat('y', 'es_ES').format(date);
                                /*final hour =
                                    DateFormat('Hms', 'es_ES').format(date);*/
                                return  Container(
                                    width: tileWidth,
                                    height: tileHeight,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: tileHeight * 0.2,
                                          decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: Text(
                                                tasks.documents[index]
                                                    .data['grade']
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: tileWidth,
                                          height: tileHeight * 0.7,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: '$day\n',
                                                          style: const TextStyle(color: Colors.black,
                                                              fontSize: 28,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: '$dayWeek\n',
                                                          style: const TextStyle(color: Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: '$month $year',
                                                          style: const TextStyle(color: Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ])),
                                                Center(
                                                    child: ElevatedButton(
                                                        onPressed: () =>
                                                            logic.dialogTask(
                                                                tasks.documents[
                                                                    index]),
                                                        child:
                                                            const Text('Ver')))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                              },
                              itemCount: tasks.documents.length,
                            );
                          })
                        : const Center(
                            child: Text('Tareas no encontradas'),
                          ),
                  );
                }),        const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
