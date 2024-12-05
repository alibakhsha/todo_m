import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_m/models/task_model.dart';

class TaskModel {
  String taskName;
  String taskStartDate;
  String taskEndDate;
  String description;
  RxBool isDone;
  Color color;
  IconData icon;
  String taskGroup;

  TaskModel({
    required this.taskName,
    required this.taskStartDate,
    required this.taskEndDate,
    required this.description,
    required this.isDone,
    required this.color,
    required this.icon,
    required this.taskGroup,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskStartDate': taskStartDate,
      'taskEndDate': taskEndDate,
      'description': description,
      'isDone': isDone.value,
      'color': color.value,
      'icon': icon.codePoint,
      'taskGroup': taskGroup,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        taskName: json['taskName'],
        taskStartDate: json['taskStartDate'].toString(),
        taskEndDate: json['taskEndDate'].toString(),
        description: json['description'].toString(),
        isDone: RxBool(json['isDone']),
        color: Color(json['color']),
        icon: IconData(json['icon']),
        taskGroup: json['taskGroup']);
  }
}
