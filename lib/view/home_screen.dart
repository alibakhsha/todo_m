import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/view/add_task_screen.dart';
import 'package:todo_m/controller/home_controller.dart';
import 'package:todo_m/view/edit_task_screen.dart';
import 'package:todo_m/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TaskController taskController = Get.put(TaskController());

  HomeScreen({super.key});

  void editButtonHandler() {
    taskController.update();
    Get.to(EditTaskScreen());
  }

  void addTaskButtonHandler() {
    taskController.update();
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
              child: taskController.tasks.isEmpty
                  ? Center(
                      child: Text(
                        "List is empty",
                        style: textTheme.bodyLarge,
                      ),
                    )
                  : Obx(
                      () => ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: taskController.tasks.length,
                          itemBuilder: (context, index) {
                            var task = homeController.tasks[index];
                            var apiTask = taskController.tasks[index];
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 4, color: task.color)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: task.color.withOpacity(0.1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    task.icon,
                                                    size: 14,
                                                    color: task.color,
                                                  ),
                                                  Text(
                                                    apiTask.title!,
                                                    style: TextStyle(
                                                        color: task.color),
                                                  ),
                                                  Text(
                                                    '${apiTask.createdAt!.year.toString()}/${apiTask.createdAt!.month.toString()}/${apiTask.createdAt!.day.toString()}',
                                                    style: TextStyle(
                                                        color: task.color
                                                            .withOpacity(0.3)),
                                                  ),
                                                ]),
                                            Obx(
                                              () => InkWell(
                                                  onTap: () => homeController
                                                      .toggleTask(index),
                                                  child: task.isDone.value
                                                      ? Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          1000)),
                                                              color:
                                                                  Colors.white),
                                                          child: Center(
                                                              child: ImageIcon(
                                                            AssetImage(Assets
                                                                .images
                                                                .checkTask
                                                                .path),
                                                            size: 13,
                                                            color: task.color,
                                                          )),
                                                        )
                                                      : Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          1000)),
                                                              color:
                                                                  Colors.white),
                                                        )),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    ),
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
