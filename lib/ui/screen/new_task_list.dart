import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_count_summary_model.dart';
import 'package:task_manager/models/task_list_model.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

import '../../models/task_count_model.dart';
import '../widget/summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskProcessing = false;
  bool getTaskCountSummaryProcessing = false;
  TaskListModel taskListModel = TaskListModel();
  TaskCountSummaryListModel taskCountSummaryListModel =
      TaskCountSummaryListModel();

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummaryProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTaskList() async {
    getNewTaskProcessing = true;
    getTaskCountSummaryProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskProcessing = false;
    getTaskCountSummaryList();
    getTaskCountSummaryProcessing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskCountSummaryList();
    getNewTaskList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddNewTaskScreen(updateStatusCount: getNewTaskList)));
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileCard(),
              Visibility(
                  visible: getTaskCountSummaryProcessing == false &&
                      (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                          false),
                  replacement: const Center(child: LinearProgressIndicator()),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            taskCountSummaryListModel.taskCountList?.length ??
                                0,
                        itemBuilder: (context, index) {
                          TaskCount taskCount =
                              taskCountSummaryListModel.taskCountList![index];
                          return FittedBox(
                              child: SummaryCard(
                                  count: taskCount.sum.toString(),
                                  title: taskCount.sId ?? ''));
                        }),
                  )),
              Expanded(
                  child: Visibility(
                visible: getNewTaskProcessing == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getNewTaskList,
                  child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getNewTaskList();
                          },
                          showProgress: (inProgress) {
                            getNewTaskProcessing = inProgress;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        );
                      }),
                ),
              ))
            ],
          ),
        ));
  }
}
