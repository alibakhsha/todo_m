import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_m/models/data_model.dart';

class HomeController extends GetxController {
  var tasks = <TaskModel>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void addTask(
    String title,
    String startDate,
    String endDate,
    String description,
    Color color,
    IconData icon,
    String taskGroup,
  ) {
    tasks.add(TaskModel(
      icon: icon,
      taskName: title,
      color: color,
      taskStartDate: startDate,
      taskEndDate: endDate,
      description: description,
      isDone: false.obs,
      taskGroup: taskGroup,
    ));
    saveTasks();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
  }

  void saveTasks() {
    List<Map<String, dynamic>> jsonTasks =
        tasks.map((task) => task.toJson()).toList();
    box.write('tasks', jsonTasks);
  }

  void loadTasks() {
    List<dynamic>? storedTasks = box.read<List<dynamic>>('tasks');
    if (storedTasks != null) {
      tasks.assignAll(
          storedTasks.map((json) => TaskModel.fromJson(json)).toList());
    } else {
      tasks.clear();
    }
  }

  void toggleTask(int index) {
    tasks[index].isDone.value = !tasks[index].isDone.value;
    saveTasks();
  }

    void updateTask(int index, TaskModel updatedTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = updatedTask;
      saveTasks(); 
    } else {
      Get.snackbar(
        'Error',
        'Task not found!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
