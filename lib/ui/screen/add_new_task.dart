import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screen/main_nav_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController subTEController = TextEditingController();
  final TextEditingController desTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool addTaskProcessing = false;

  Future<void> createTask() async {
    if (formKey.currentState!.validate()) {
      addTaskProcessing = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": subTEController.text.trim(),
        "description": desTEController.text.trim(),
        "status": "New"
      });
      addTaskProcessing = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        if (mounted) {
          showSnackMessage(context, "New task created");
        }
        subTEController.clear();
        desTEController.clear();
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNavScreen()));
        }
      } else {
        if (mounted) {
          showSnackMessage(context, "Task creation failed", true);
        }
      }
    }
  }

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
                          controller: subTEController,
                          validator: validator,
                          decoration:
                              const InputDecoration(hintText: "Subject")),
                      const SizedBox(height: 16),
                      TextFormField(
                          maxLines: 5,
                          controller: desTEController,
                          validator: validator,
                          decoration:
                              const InputDecoration(hintText: "Description")),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: addTaskProcessing
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: createTask,
                                child: const Icon(Icons.add_circle),
                              ),
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

  String? validator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Enter valid value';
    }
    return null;
  }

  @override
  void dispose() {
    subTEController.dispose();
    desTEController.dispose();
    super.dispose();
  }
}
