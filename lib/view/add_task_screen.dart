import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/home_controller.dart';
import 'package:todo_m/controller/task_controller.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/models/task_model.dart';
import 'package:todo_m/view/home_screen.dart';

import '../gen/assets.gen.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TaskController taskController = Get.put(TaskController());
  Rx<TaskGroup> taskGroup = TaskGroup(null, null, null).obs;
  String? _selectedTaskGroup;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Rx<DateTime?> _startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> _endDate = Rx<DateTime?>(null);

  AddTaskScreen({super.key});

  // AddTaskScreen({super.key, required this.task});
  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isStartDate) {
        _startDate.value = picked;
      } else {
        _endDate.value = picked;
      }
    }
  }

  void addTaskButtonHandler() {
    if (_selectedTaskGroup == null ||
        _taskNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _startDate.value == null ||
        _endDate.value == null) {
      Get.snackbar(
        'Snackbar',
        'Please complete the fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
      return;
    }

    final selectedGroup = TaskData.taskGroup.firstWhereOrNull(
      (group) => group.name == _selectedTaskGroup,
    );

    if (selectedGroup == null || selectedGroup.name!.isEmpty) {
      Get.snackbar(
        'Snackbar',
        'Invalid Task Group selection.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    homeController.addTask(
      _taskNameController.text,
      '${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}',
      '${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}',
      _descriptionController.text,
      selectedGroup.color!,
      selectedGroup.icon!,
      selectedGroup.name!,
    );

    final task = ApiTaskModel(
        title: _taskNameController.text,
        description: _descriptionController.text,
        isCompleted: false,
        createdAt: _startDate.value);

    taskController.createTask(task);
    taskController.fetchTasks();
    taskController.update();

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.fromLTRB(30, 62, 30, 0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "ADD TASK",
                  style: textTheme.titleLarge,
                )),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 63,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: DropdownButtonFormField<String>(
                        iconSize: 0,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 48,
                          ),
                          labelText: 'Task Group',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        value: _selectedTaskGroup,
                        items: TaskData.taskGroup.map((group) {
                          return DropdownMenuItem<String>(
                            value: group.name,
                            child: Row(
                              children: [
                                Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      color: group.color!.withOpacity(0.2),
                                    ),
                                    child: Icon(group.icon,
                                        size: 14, color: group.color)),
                                const SizedBox(width: 8),
                                Text(group.name!),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedTaskGroup = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 63,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: TextField(
                        controller: _taskNameController,
                        decoration: InputDecoration(
                          labelText: 'Task Name',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 142,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 95, 51, 225)
                                    .withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: const Offset(0, 7))
                          ]),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: textTheme.bodySmall,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    dateContainer(
                        context, textTheme, true, 'Start Date', _startDate),
                    const SizedBox(height: 16),
                    dateContainer(
                        context, textTheme, false, 'End Date', _endDate),
                    const SizedBox(height: 100),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Add Task", style: textTheme.labelMedium),
                              const SizedBox(
                                width: 8,
                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateContainer(BuildContext context, TextTheme textTheme, bool pickDate,
      String s, Rx<DateTime?> dateTime) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 95, 51, 225).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 7))
          ]),
      child: GestureDetector(
        onTap: () => _pickDate(context, pickDate),
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
                labelText: s,
                labelStyle: textTheme.bodySmall,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: ImageIcon(
                  AssetImage(Assets.images.calendar.path),
                  size: 14,
                  color: const Color(0xff5F33E1),
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 48,
                )),
            controller: TextEditingController(
              text: dateTime.value != null
                  ? '${dateTime.value!.day}/${dateTime.value!.month}/${dateTime.value!.year}'
                  : '',
            ),
          ),
        ),
      ),
    );
  }
}
