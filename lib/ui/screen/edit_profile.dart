import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/user_model.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController mobileTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  XFile? photo;
  GlobalKey<FormState> formKey = GlobalKey();
  bool updateProfileProcessing = false;

  Future<void> updateProfile() async {
    updateProfileProcessing = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": emailTEController.text.trim(),
      "firstName": firstNameTEController.text.trim(),
      "lastName": lastNameTEController.text.trim(),
      "mobile": mobileTEController.text.trim(),
    };
    if (passwordTEController.text.isNotEmpty) {
      inputData['password'] = passwordTEController.text.trim();
    }
    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    updateProfileProcessing = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
          email: emailTEController.text.trim(),
          firstName: firstNameTEController.text.trim(),
          lastName: lastNameTEController.text.trim(),
          mobile: mobileTEController.text.trim(),
          photo: photoInBase64 ?? AuthController.user?.photo));
      if (mounted) {
        showSnackMessage(context, "profile updated successfully");
      }
    } else {
      if (mounted) {
        showSnackMessage(context, "update failed, try again");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailTEController.text = AuthController.user?.email ?? '';
    firstNameTEController.text = AuthController.user?.firstName ?? '';
    lastNameTEController.text = AuthController.user?.lastName ?? '';
    mobileTEController.text = AuthController.user?.mobile ?? '';
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
                    Visibility(
                      visible: updateProfileProcessing == false,
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
                    ),
                  ],
                ),
              )))
            ],
          ),
        ),
      ),
    );
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
