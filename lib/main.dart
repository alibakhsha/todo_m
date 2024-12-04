import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_m/view/first_screen.dart';
import 'package:todo_m/component/thems.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_m/view/home_screen.dart';

void main() async {
  await GetStorage.init();
  bool isFirstLaunch = GetStorage().read('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    GetStorage().write(
        'isFirstLaunch', false); // مقدار isFirstLaunch را به false تغییر بده
  }
  runApp(MyApp(
    isFirstLaunch: isFirstLaunch,
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  const MyApp({super.key, required this.isFirstLaunch});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themsData,
      home: isFirstLaunch ? FirstScreen() : HomeScreen(),
    );
  }
}
