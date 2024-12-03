import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo_m/models/data_model.dart';

class HomeController extends GetxController {
  var tasks = <TaskModel>[].obs;

  void addTask(
    String title,
    String date,
    Color color,
    IconData icon,
  ) {
    tasks.add(TaskModel(
        icon: icon,
        taskName: title,
        color: color,
        taskDate: date, 
        isDone: false.obs,
        
        ));
  }

  void toggleTask(int index) {
    tasks[index].isDone.value = !tasks[index].isDone.value;
  }
}
