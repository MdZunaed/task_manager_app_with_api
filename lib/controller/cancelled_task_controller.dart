import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_list_model.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTaskProcessing = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTaskProcessing => _getCancelledTaskProcessing;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getCancelledTaskList() async {
    _getCancelledTaskProcessing = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelledTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _getCancelledTaskProcessing = false;
    update();
  }
}