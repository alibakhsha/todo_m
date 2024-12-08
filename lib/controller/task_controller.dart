// import 'package:get/get.dart';
// import 'package:todo_m/models/api_task_model.dart';
// import 'package:todo_m/service/api_service.dart';

// class TaskController extends GetxController {
//   final ApiService _apiService = ApiService();

//   var tasks = <ApiTaskModel>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchTasks();
//   }

//   Future<void> fetchTasks() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       final fetchedTasks = await _apiService.getTasks();
//       tasks.assignAll(fetchedTasks);
//     } catch (e) {
//       errorMessage.value = 'Failed to load tasks: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<ApiTaskModel?> fetchTaskById(String taskId) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       return await _apiService.getTaskById(taskId);
//     } catch (e) {
//       errorMessage.value = 'Failed to fetch task: $e';
//       return null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> createTask(ApiTaskModel task) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       await _apiService.createTask(task);
//       fetchTasks();
//     } catch (e) {
//       errorMessage.value = 'Failed to create task: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateTask(String taskId, ApiTaskModel updatedTask) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       await _apiService.updateTask(taskId, updatedTask);
//       fetchTasks();
//     } catch (e) {
//       errorMessage.value = 'Failed to update task: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> deleteTask(String taskId) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       await _apiService.deleteTask(taskId);
//       tasks.removeWhere((task) => task.id == taskId);
//     } catch (e) {
//       errorMessage.value = 'Failed to delete task: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Future<void> toggleTask(int index) async{
//   //   tasks[index].isCompleted.value = !tasks[index].isCompleted.value;
//   //   fetchTaskById(index.toString());
//   // }
// }


import 'package:get/get.dart';
import 'package:todo_m/models/api_task_model.dart';
import 'package:todo_m/service/api_service.dart';

class TaskController extends GetxController {
  final ApiService _apiService = ApiService();

  // Reactive variables
  var tasks = <ApiTaskModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // Fetch all tasks from the API
  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedTasks = await _apiService.getTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      errorMessage.value = 'Failed to load tasks: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch a single task by ID
  Future<ApiTaskModel?> fetchTaskById(String taskId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      return await _apiService.getTaskById(taskId);
    } catch (e) {
      errorMessage.value = 'Failed to fetch task: $e';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new task
  Future<void> createTask(ApiTaskModel task) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _apiService.createTask(task);
      tasks.add(task);
    } catch (e) {
      errorMessage.value = 'Failed to create task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing task
  Future<void> updateTask(String taskId, ApiTaskModel updatedTask) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _apiService.updateTask(taskId, updatedTask);
      int index = tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
    } catch (e) {
      errorMessage.value = 'Failed to update task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      var del = await _apiService.deleteTask(taskId);
      tasks.removeWhere((task) => task.id == taskId);
    } catch (e) {
      errorMessage.value = 'Failed to delete task: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle task completion status
  Future<void> toggleTask(String taskId) async {
    try {
      int index = tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        var task = tasks[index];
        task.isCompleted = !(task.isCompleted ?? false);
        await _apiService.updateTask(taskId, task);
        tasks[index] = task;
      }
    } catch (e) {
      errorMessage.value = 'Failed to toggle task: $e';
    }
  }
}
