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

// import 'package:get/get.dart';
// import 'package:todo_m/models/api_task_model.dart';
// import 'package:todo_m/models/data_model.dart';
// import 'package:todo_m/service/api_service.dart';

// class HomeController extends GetxController {
//   var tasks = <TaskModel>[].obs;
//   var apiTasks = <ApiTaskModel>[].obs;
//   final ApiService _apiService = ApiService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchTasksFromApi();
//   }

//   void fetchTasksFromApi() async {
//     try {
//       final fetchedApiTasks = await _apiService.fetchTasks();
//       apiTasks.assignAll(fetchedApiTasks);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch tasks: $e');
//     }
//   }

//   void addApiTask(ApiTaskModel task) async {
//     try {
//       final newTask = await _apiService.createTask(task);
//       apiTasks.add(newTask);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to add task: $e');
//     }
//   }

//   void deleteApiTask(String taskId) async {
//     try {
//       await _apiService.deleteTask(taskId);
//       apiTasks.removeWhere((task) => task.id.toString() == taskId);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete task: $e');
//     }
//   }

//   void updateApiTask(String taskId, ApiTaskModel updatedTask) async {
//     try {
//       final task = await _apiService.updateTask(taskId, updatedTask.toJson());
//       final index = apiTasks.indexWhere((t) => t.id.toString() == taskId);
//       if (index != -1) {
//         apiTasks[index] = task;
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update task: $e');
//     }
//   }

//   void toggleTask(int index) async {
//     try {
//       // یافتن تسک مربوطه
//       final task = apiTasks[index];

//       // ایجاد نسخه به‌روزرسانی‌شده از تسک
//       final updatedTask = ApiTaskModel(
//         id: task.id,
//         title: task.title,
//         description: task.description,
//         isCompleted: !task.isCompleted, // تغییر وضعیت
//         createdAt: task.createdAt,
//       );

//       // ارسال تغییرات به سرور
//       updateApiTask(task.id.toString(), updatedTask);

//       // به‌روزرسانی لیست محلی
//       apiTasks[index] = updatedTask;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to toggle task: $e');
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:todo_m/models/data_model.dart';
// import 'package:todo_m/service/api_service.dart';

// class HomeController extends GetxController {
//   var tasks = <TaskModel>[].obs;
//   final box = GetStorage();
//   final ApiService apiService = ApiService();

//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }

//   void loadTasks() async {
//     try {
//       tasks.assignAll(await apiService.getTasks());
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load tasks');
//     }
//   }

//   void addTask(TaskModel task) async {
//     try {
//       await apiService.createTask(task);
//       tasks.add(task);
//       saveTasks();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create task');
//     }
//   }

//   // void addTask(
// //   String id,
// //   String title,
// //   String startDate,
// //   String endDate,
// //   String description,
// //   Color color,
// //   IconData icon,
// //   String taskGroup,
// // ) async {
// //   TaskModel newTask = TaskModel(
// //     id: id,
// //     taskName: title,
// //     taskStartDate: startDate,
// //     taskEndDate: endDate,
// //     description: description,
// //     isDone: false.obs,
// //     color: color,
// //     icon: icon,
// //     taskGroup: taskGroup,
// //   );

// //   try {
// //     await apiService.createTask(newTask);
// //     tasks.add(newTask);
// //     saveTasks();
// //   } catch (e) {
// //     Get.snackbar('Error', 'Failed to create task');
// //   }
// // }


//   void updateTask(int index, TaskModel updatedTask) async {
//     if (index >= 0 && index < tasks.length) {
//       try {
//         await apiService.updateTask(tasks[index].id as int, updatedTask);
//         tasks[index] = updatedTask;
//         saveTasks();
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to update task');
//       }
//     } else {
//       Get.snackbar('Error', 'Task not found!');
//     }
//   }

//   void deleteTask(int index) async {
//     if (index >= 0 && index < tasks.length) {
//       try {
//         await apiService.deleteTask(tasks[index].id as int);
//         tasks.removeAt(index);
//         saveTasks();
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to delete task');
//       }
//     }
//   }

//   void saveTasks() {
//     List<Map<String, dynamic>> jsonTasks = tasks.map((task) => task.toJson()).toList();
//     box.write('tasks', jsonTasks);
//   }

//   void toggleTask(int index) {
//     tasks[index].isDone.value = !tasks[index].isDone.value;
//     saveTasks();
//   }
// }
