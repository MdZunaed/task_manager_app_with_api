import 'package:flutter/material.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../../models/task_list_model.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool getCancelledTaskProcessing = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {
    getCancelledTaskProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancelledTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCancelledTaskList();
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
            visible: getCancelledTaskProcessing == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: RefreshIndicator(
              onRefresh: getCancelledTaskList,
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                      onStatusChange: () {
                        getCancelledTaskList();
                      },
                      showProgress: (inProgress) {
                        getCancelledTaskProcessing = inProgress;
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
