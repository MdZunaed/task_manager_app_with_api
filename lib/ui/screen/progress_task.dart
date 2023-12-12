import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/progress_task_controller.dart';
import '../widget/profile_card.dart';
import '../widget/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskController>().getProgressTaskList();
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   });
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
              child: GetBuilder<ProgressTaskController>(builder: (controller) {
            return Visibility(
              visible: controller.getProgressTaskProcessing == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: RefreshIndicator(
                onRefresh: controller.getProgressTaskList,
                child: ListView.builder(
                    itemCount: controller.taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        statusBgColor: Colors.orange,
                        task: controller.taskListModel.taskList![index],
                        onStatusChange: () {
                          controller.getProgressTaskList();
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
