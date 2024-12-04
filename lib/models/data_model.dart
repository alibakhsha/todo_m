import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskModel {
  String taskName;
  String taskDate;
  RxBool isDone;
  Color color;
  IconData icon;

  TaskModel({
    required this.taskName,
    required this.taskDate,
    required this.isDone,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDate': taskDate,
      'isDone': isDone.value,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        taskName: json['taskName'],
        taskDate: json['taskDate'],
        isDone: RxBool(json['isDone']),
        color: Color(json['color']),
        icon: IconData(json['icon']));
  }

}
