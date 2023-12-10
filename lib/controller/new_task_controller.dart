import 'package:get/get.dart';

import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';
import '../data/utility/urls.dart';
import '../models/task_list_model.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskProcessing = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskProcessing => _getNewTaskProcessing;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    _getNewTaskProcessing = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
