import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task_count_summary.dart';
import 'package:task_manager/models/task_list_model.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

import '../../models/task_count.dart';
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
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskProcessing = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewTaskScreen()));
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileCard(),
              // const SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     physics: BouncingScrollPhysics(),
              //     child: Row(
              //       children: [
              //         SummaryCard(count: "9", title: "New"),
              //         SummaryCard(count: "9", title: "In Progress"),
              //         SummaryCard(count: "9", title: "Completed"),
              //         SummaryCard(count: "9", title: "Cancelled"),
              //       ],
              //     )),
              Visibility(
                  visible: getTaskCountSummaryProcessing == false &&
                      (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                          false),
                  replacement: const Center(child: LinearProgressIndicator()),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                      );
                    }),
              ))
            ],
          ),
        ));
  }
}
