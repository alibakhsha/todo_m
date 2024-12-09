import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/view/edit_task_complete_screen.dart';
import 'package:todo_m/view/home_screen.dart';

import '../gen/assets.gen.dart';

class EditTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  EditTaskScreen({super.key});

  void changeButtonHandler() {
    taskController.update();
    taskController.fetchTasks();
    Get.offAll(HomeScreen());
  }

  void editRoutePageHandler(ApiTaskModel apiTaskModel) {
    taskController.fetchTasks();
    taskController.update();
    Get.to(EditPageCompleteScreen(
      apiTaskModel: apiTaskModel,
    ));
  }

  void deleteTaskHandler(int index) {
    int taskId = taskController.tasks[index].id!;

    taskController.deleteTask(taskId.toString());
    taskController.update();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 62, 30, 0),
        child: Column(
          children: [
            Center(
                child: Text(
              "EDIT",
              style: textTheme.titleLarge,
            )),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 580,
              color: Colors.white,
              child: Obx(() {
                if (taskController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Text(
                      "List is empty",
                      style: textTheme.bodyLarge,
                    ),
                  );
                }
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      var apiTask = taskController.tasks[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 4, color: apiTask.color!)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                color: apiTask.color!.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 0, 0, 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              apiTask.icon,
                                              size: 14,
                                              color: apiTask.color,
                                            ),
                                            Text(
                                              apiTask.title!,
                                              style: TextStyle(
                                                  color: apiTask.color),
                                            ),
                                            Text(
                                              '${apiTask.createdAt!.year.toString()}/${apiTask.createdAt!.month.toString()}/${apiTask.createdAt!.day.toString()}',
                                              style: TextStyle(
                                                  color: apiTask.color!
                                                      .withOpacity(0.3)),
                                            ),
                                          ]),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () =>
                                                editRoutePageHandler(apiTask),
                                            child: ImageIcon(
                                              AssetImage(Assets
                                                  .images.tablerEdit.path),
                                              size: 24,
                                              color: apiTask.color,
                                            )),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          width: 56,
                                          height: 63,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15))),
                                          child: IconButton(
                                              onPressed: () =>
                                                  deleteTaskHandler(index),
                                              icon: ImageIcon(
                                                AssetImage(
                                                    Assets.images.delete.path),
                                                size: 18,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: size.width / 1.17,
              height: 54,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 95, 51, 225),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: InkWell(
                onTap: changeButtonHandler,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      Center(child: Text("Done", style: textTheme.labelMedium)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
