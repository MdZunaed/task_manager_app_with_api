import 'package:get/get.dart';
import 'package:task_manager/controller/new_task_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddTaskController extends GetxController {
  bool _addTaskProcessing = false;
  String _message = "";

  bool get addTaskProcessing => _addTaskProcessing;

  String get message => _message;

  Future<bool> addNewTask(String title, String description) async {
    _addTaskProcessing = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createNewTask,
        body: {"title": title, "description": description, "status": "New"});
    _addTaskProcessing = false;
    update();
    if (response.isSuccess) {
      Get.find<NewTaskController>().getNewTaskList();
      _message = "New task created";
      update();
      return true;
    } else {
      _message = "Task creation failed";
      update();
      return false;
    }
  }
}
