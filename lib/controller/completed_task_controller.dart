import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_list_model.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskProcessing = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTaskProcessing => _getCompletedTaskProcessing;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getCompletedTaskList() async {
    _getCompletedTaskProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCompletedTaskProcessing = false;
    update();
  }
}
