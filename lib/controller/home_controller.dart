import 'package:flutter/material.dart';
import 'package:get/get.dart';
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





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:todo_m/models/data_model.dart';

// class HomeController extends GetxController {
//   var tasks = <TaskModel>[].obs;
//   final Dio _dio = Dio();
//   final String apiUrl = 'https://gandom-shjpr9s-projects.vercel.app';

//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }

//   Future<void> loadTasks() async {
//     try {
//       final response = await _dio.get('$apiUrl/api/tasks');
//       if (response.statusCode == 200) {
//         tasks.assignAll(
//           (response.data as List)
//               .map((json) => TaskModel.fromJson(json))
//               .toList(),
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to load tasks',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   Future<void> addTask(
//     int id,
//     String title,
//     String startDate,
//     String endDate,
//     String description,
//     Color color,
//     IconData icon,
//     String taskGroup,
//   ) async {
//       final taskData = {
//         'id': id,
//         'taskName': title,
//         'taskStartDate': startDate,
//         'taskEndDate': endDate,
//         'description': description,
//         'color': color.value.toString(),
//         'icon': icon.codePoint,
//         'taskGroup': taskGroup,
//       };
//       final response = await _dio.post('$apiUrl/api/task', data: taskData);
//       if (response.statusCode == 200) {
//         loadTasks();
//       }

//   }

//   Future<void> deleteTask(int index) async {
//     final taskId = tasks[index].id;
//     try {
//       final response = await _dio.delete('$apiUrl/apitask/$taskId');
//       if (response.statusCode == 200) {
//         tasks.removeAt(index);
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to delete task',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   Future<void> updateTask(int index, TaskModel updatedTask) async {
//     try {
//       final updatedData = updatedTask.toJson();
//       final response =
//           await _dio.put('$apiUrl/api/task/${updatedTask.id}', data: updatedData);
//       if (response.statusCode == 200) {
//         tasks[index] = updatedTask;
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to update task',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   Future<void> toggleTask(int index) async {
//     tasks[index].isDone.value = !tasks[index].isDone.value;
//     try {
//       final updatedTask = tasks[index];
//       final response = await _dio.put('$apiUrl/api/task/${updatedTask.id}',
//           data: updatedTask.toJson());
//       if (response.statusCode != 200) {
//         Get.snackbar(
//           'Error',
//           'Failed to update task status',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to toggle task status',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }
