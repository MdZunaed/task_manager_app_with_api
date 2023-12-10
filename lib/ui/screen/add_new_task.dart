import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/add_task_controller.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController descriptionTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileCard(),
            Expanded(
                child: BodyBackground(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text("Add New Task",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: titleTEController,
                          validator: validator,
                          decoration: const InputDecoration(hintText: "Title")),
                      const SizedBox(height: 16),
                      TextFormField(
                          maxLines: 5,
                          controller: descriptionTEController,
                          validator: validator,
                          decoration:
                              const InputDecoration(hintText: "Description")),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: GetBuilder<AddTaskController>(
                            builder: (controller) {
                          return Visibility(
                            visible: controller.addTaskProcessing == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  addNewTask();
                                }
                              },
                              child: const Icon(Icons.add_circle),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> addNewTask() async {
    final response = await controller.addNewTask(
        titleTEController.text.trim(), descriptionTEController.text.trim());
    if (response) {
      titleTEController.clear();
      descriptionTEController.clear();
      if (mounted) {
        showSnackMessage(context, controller.message);
      }
    } else {
      if (mounted) {
        showSnackMessage(context, controller.message, true);
      }
    }
  }

  String? validator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Enter valid value';
    }
    return null;
  }

  @override
  void dispose() {
    titleTEController.dispose();
    descriptionTEController.dispose();
    super.dispose();
  }
}

// onWillPop: () async {
// await Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(builder: (context) => const BottomNavScreen()),
// (route) => false);
// return false;
// },
