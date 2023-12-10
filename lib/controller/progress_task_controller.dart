import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_list_model.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskProcessing = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getProgressTaskProcessing => _getProgressTaskProcessing;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getProgressTaskList() async {
    _getProgressTaskProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getProgressTaskProcessing = false;
    update();
  }
}
