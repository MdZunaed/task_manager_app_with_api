import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_count_summary_model.dart';

class TaskSummaryController extends GetxController {
  bool _getTaskCountSummaryProcessing = false;
  TaskCountSummaryListModel _taskCountSummaryListModel =
      TaskCountSummaryListModel();

  bool get getTaskCountSummaryProcessing => _getTaskCountSummaryProcessing;

  TaskCountSummaryListModel get taskCountSummaryListModel =>
      _taskCountSummaryListModel;

  Future<void> getTaskCountSummaryList() async {
    _getTaskCountSummaryProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    _getTaskCountSummaryProcessing = false;
    update();
  }
}
