import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/home_controller.dart';
import 'package:todo_m/models/list_data.dart';
import 'package:todo_m/view/edit_page_complete_screen.dart';
import 'package:todo_m/view/home_screen.dart';

import '../gen/assets.gen.dart';

class EditTaskScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  void changeButtonHandler() {
    Get.offAll(HomeScreen());
  }

  void editRoutePageHandler() {
    Get.to(EditPageCompleteScreen());
  }

  void deleteTaskHandler() {
    // controller.tasks.remove()
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
              child: Obx(
                () => ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.tasks.length,
                    itemBuilder: (context, index) {
                      var task = controller.tasks[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 4, color: task.color)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                color: task.color.withOpacity(0.2)),
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
                                              task.icon,
                                              size: 14,
                                              color: task.color,
                                            ),
                                            Text(
                                              task.taskName,
                                              style: textTheme.bodyMedium,
                                            ),
                                            Text(
                                              task.taskDate,
                                              style: TextStyle(
                                                  color: task.color
                                                      .withOpacity(0.3)),
                                            ),
                                          ]),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: editRoutePageHandler,
                                            child: ImageIcon(
                                              AssetImage(Assets
                                                  .images.tablerEdit.path),
                                              size: 24,
                                              color: task.color,
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
                                                  controller.deleteTask(index),
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
