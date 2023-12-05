import 'package:flutter/material.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../models/task_list_model.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool getProgressTaskProcessing = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getProgressTaskProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getProgressTaskProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
              child: Visibility(
            visible: getProgressTaskProcessing == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: getProgressTaskList,
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      statusBgColor: Colors.orange,
                      task: taskListModel.taskList![index],
                      onStatusChange: () {
                        getProgressTaskList();
                      },
                      showProgress: (inProgress) {
                        getProgressTaskProcessing = inProgress;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                    );
                  }),
            ),
          )),
        ],
      ),
    ));
  }
}
