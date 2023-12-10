import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/update_profile_controller.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController mobileTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  XFile? photo;
  GlobalKey<FormState> formKey = GlobalKey();
  AuthController authController = Get.find<AuthController>();
  UpdateProfileController updateProfileController =
      Get.find<UpdateProfileController>();

  @override
  void initState() {
    super.initState();
    emailTEController.text = authController.user?.email ?? '';
    firstNameTEController.text = authController.user?.firstName ?? '';
    lastNameTEController.text = authController.user?.lastName ?? '';
    mobileTEController.text = authController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const ProfileCard(enableOnTap: false),
              Expanded(
                  child: BodyBackground(
                      child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text("Update Profile",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    photoPicker(),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: emailTEController,
                        validator: validator,
                        decoration: const InputDecoration(hintText: "Email")),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: firstNameTEController,
                        validator: validator,
                        decoration:
                            const InputDecoration(hintText: "First Name")),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: lastNameTEController,
                        validator: validator,
                        decoration:
                            const InputDecoration(hintText: "Last Name")),
                    const SizedBox(height: 8),
                    TextFormField(
                        controller: mobileTEController,
                        validator: validator,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(hintText: "Mobile")),
                    const SizedBox(height: 8),
                    TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "Password (optional)")),
                    const SizedBox(height: 16),
                    GetBuilder<UpdateProfileController>(builder: (controller) {
                      return Visibility(
                        visible: controller.updateProfileProcessing == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text("Save"),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                updateProfile();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              )))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    final response = await updateProfileController.updateProfile(
        emailTEController.text.trim(),
        firstNameTEController.text.trim(),
        lastNameTEController.text.trim(),
        mobileTEController.text.trim(),
        passwordTEController.text.trim(),
        photo);
    if (response) {
      if (mounted) {
        showSnackMessage(context, updateProfileController.message);
      }
    } else {
      if (mounted) {
        showSnackMessage(context, updateProfileController.message, true);
      }
    }
  }

  InkWell photoPicker() {
    return InkWell(
      onTap: () async {
        final XFile? image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 50);
        if (image != null) {
          photo = image;
          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Container(
        height: 55,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                    height: 55,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text("Photo"))),
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: photo == null
                      ? const Text('select photo')
                      : Text(photo!.name),
                )),
          ],
        ),
      ),
    );
  }

  String? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Enter password';
    }
    return null;
  }
}
