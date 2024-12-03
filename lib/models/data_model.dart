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
    required this.icon,
    required this.taskName,
    required this.isDone,
    required this.color,
    required this.taskDate,
  });
}
