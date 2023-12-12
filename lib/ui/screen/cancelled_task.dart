import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/cancelled_task_controller.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CancelledTaskController>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
              child: GetBuilder<CancelledTaskController>(builder: (controller) {
            return Visibility(
              visible: controller.getCancelledTaskProcessing == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: RefreshIndicator(
                onRefresh: controller.getCancelledTaskList,
                child: ListView.builder(
                    itemCount: controller.taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        statusBgColor: Colors.red,
                        task: controller.taskListModel.taskList![index],
                        onStatusChange: () {
                          controller.getCancelledTaskList();
                        },
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
