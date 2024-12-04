import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/controller/home_controller.dart';
import 'package:todo_m/models/task_model.dart';
import 'package:todo_m/view/home_screen.dart';


import '../gen/assets.gen.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  Rx<TaskGroup> taskGroup = TaskGroup(null, null, null).obs;
  String? _selectedTaskGroup;

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Rx<DateTime?> _startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> _endDate = Rx<DateTime?>(null);

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
        _startDate == null ||
        _endDate == null) {
      Get.snackbar(
        'Snackbar',
        'Please complete the fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }

    final selectedGroup = TaskData.taskGroup.firstWhereOrNull(
      (group) => group.name == _selectedTaskGroup,
    );

    if (selectedGroup == null) {
      Get.snackbar(
        'Snackbar',
        'Invalid Task Group selection.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    controller.addTask(
      _taskNameController.text,
      '${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}',
      selectedGroup.color!,
      selectedGroup.icon!,
      selectedGroup.name!,
    );

    Get.offAll(HomeScreen());

    // else {
    //   controller.addTask(
    //       _selectedTaskGroup.value!,
    //       '${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}',
    //       taskGroup.value.color!,
    //       taskGroup.value.icon!,
    //       taskGroup.value.name!);
    //   Get.offAll(HomeScreen());
    // }
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
                                Icon(group.icon, color: group.color),
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
                      child: GestureDetector(
                        onTap: () => _pickDate(context, true),
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Start Date',
                                labelStyle: textTheme.bodySmall,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color.fromARGB(255, 95, 51, 225),
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 48,
                                )),
                            controller: TextEditingController(
                              text: _startDate.value != null
                                  ? '${_startDate.value!.day}/${_startDate.value!.month}/${_startDate.value!.year}'
                                  : '',
                            ),
                          ),
                        ),
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
                      child: GestureDetector(
                        onTap: () => _pickDate(context, false),
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'End Date',
                                labelStyle: textTheme.bodySmall,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color.fromARGB(255, 95, 51, 225),
                                ),
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 48,
                                )),
                            controller: TextEditingController(
                              text: _endDate.value != null
                                  ? '${_endDate.value!.day}/${_endDate.value!.month}/${_endDate.value!.year}'
                                  : '',
                            ),
                          ),
                        ),
                      ),
                    ),
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
}
