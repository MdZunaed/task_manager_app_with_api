import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

import 'task_summary_controller.dart';

class TaskController extends GetxController {
  bool _taskUpdateProcessing = false;

  bool get taskUpdateProcessing => _taskUpdateProcessing;

  Future<bool> updateTaskStatus(String taskId, String status) async {
    _taskUpdateProcessing = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.updateTaskStatus(taskId, status));
    _taskUpdateProcessing = false;
    update();
    if (response.isSuccess) {
      Get.find<TaskSummaryController>().getTaskCountSummaryList();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTask(taskId) async {
    _taskUpdateProcessing = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    _taskUpdateProcessing = false;
    update();
    if (response.isSuccess) {
      Get.find<TaskSummaryController>().getTaskCountSummaryList();
      return true;
    } else {
      return false;
    }
  }
}
