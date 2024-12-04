import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskGroup {
   String? name;
   IconData? icon;
   Color? color;

  TaskGroup(this.name, this.icon, this.color);
}

class TaskData {
  static List<TaskGroup> taskGroup =[
    TaskGroup('Work', Icons.work, const Color(0xffF478B8)),
    TaskGroup('Gym', Icons.fitness_center, const Color(0xff39fc03)),
    TaskGroup('Study', Icons.school, const Color(0xff5F33E1)),
    TaskGroup('Other', Icons.list, const Color(0xfffc034e)),
  ];
}
