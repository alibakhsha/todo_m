import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/view/add_task_screen.dart';
import 'package:todo_m/view/edit_task_screen.dart';
import 'package:todo_m/gen/assets.gen.dart';

import '../component/my_components.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  HomeScreen({super.key});

  void editButtonHandler() {
    Get.to(EditTaskScreen());
  }

  void addTaskButtonHandler() {
    Get.to(AddTaskScreen());
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
              "HOME",
              style: textTheme.titleLarge,
            )),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  width: 70,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 95, 51, 225),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: InkWell(
                    onTap: editButtonHandler,
                    child: Center(
                        child: Text(
                      "Edit",
                      style: textTheme.labelSmall,
                    )),
                  ),
                ),
              ],
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
                          child: TaskTile(apiTask: apiTask,index: index));
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
                onTap: addTaskButtonHandler,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(" "),
                      Text("Add Task", style: textTheme.labelMedium),
                      ImageIcon(
                        AssetImage(Assets.images.add.path),
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
