import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/completed_task_controller.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
              child: GetBuilder<CompletedTaskController>(builder: (controller) {
            return Visibility(
              visible: controller.getCompletedTaskProcessing == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: RefreshIndicator(
                onRefresh: controller.getCompletedTaskList,
                child: ListView.builder(
                    itemCount: controller.taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        statusBgColor: Colors.lightGreen,
                        task: controller.taskListModel.taskList![index],
                        onStatusChange: () {
                          controller.getCompletedTaskList();
                        },
                        showProgress: (inProgress) {},
                      );
                    }),
              ),
            );
          })),
        ],
      ),
    ));
  }
}
