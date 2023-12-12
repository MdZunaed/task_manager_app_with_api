import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/new_task_controller.dart';
import 'package:task_manager/controller/task_summary_controller.dart';
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
  @override
  void initState() {
    super.initState();
    Get.find<TaskSummaryController>().getTaskCountSummaryList();
    // NewTaskController controller = Get.find<NewTaskController>();
    // if (controller.taskListModel.taskList!.isEmpty) {
    //   controller.getNewTaskList();
    // }
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(const AddNewTaskScreen());
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileCard(),
              GetBuilder<TaskSummaryController>(builder: (controller) {
                return Visibility(
                    visible:
                        controller.getTaskCountSummaryProcessing == false &&
                            (controller.taskCountSummaryListModel.taskCountList
                                    ?.isNotEmpty ??
                                false),
                    replacement: const Center(child: LinearProgressIndicator()),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.taskCountSummaryListModel
                                  .taskCountList?.length ??
                              0,
                          itemBuilder: (context, index) {
                            TaskCount taskCount = controller
                                .taskCountSummaryListModel
                                .taskCountList![index];
                            return FittedBox(
                                child: SummaryCard(
                                    count: taskCount.sum.toString(),
                                    title: taskCount.sId ?? ''));
                          }),
                    ));
              }),
              Expanded(
                  child: GetBuilder<NewTaskController>(builder: (controller) {
                return Visibility(
                  visible: controller.getNewTaskProcessing == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () => controller.getNewTaskList(),
                    child: ListView.builder(
                        itemCount:
                            controller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: controller.taskListModel.taskList![index],
                            onStatusChange: () {
                              controller.getNewTaskList();
                            },
                          );
                        }),
                  ),
                );
              }))
            ],
          ),
        ));
  }
}
