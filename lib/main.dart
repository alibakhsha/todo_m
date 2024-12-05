import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_m/view/first_screen.dart';
import 'package:todo_m/component/thems.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_m/view/home_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp() : isFirstLaunch = GetStorage().read('isFirstLaunch') ?? true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themsData,
      home: isFirstLaunch ? FirstScreen() : HomeScreen(),
    );
  }
}
