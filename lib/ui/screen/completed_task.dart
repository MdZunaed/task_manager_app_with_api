import 'package:flutter/material.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../models/task_list_model.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool getCompletedTaskProcessing = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCompletedTaskList() async {
    getCompletedTaskProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
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
            visible: getCompletedTaskProcessing == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: getCompletedTaskList,
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      statusBgColor: Colors.lightGreen,
                      task: taskListModel.taskList![index],
                      onStatusChange: () {
                        getCompletedTaskList();
                      },
                      showProgress: (inProgress) {
                        getCompletedTaskProcessing = inProgress;
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
