import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/update_profile.dart';
import 'package:task_manager/ui/screen/login_screen.dart';

class ProfileCard extends StatelessWidget {
  final bool enableOnTap;

  const ProfileCard({super.key, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      Uint8List imageBytes =
          const Base64Decoder().convert(controller.user?.photo ?? '');
      return ListTile(
        tileColor: Colors.green,
        leading: CircleAvatar(
            child:
                (controller.user?.photo == "" || controller.user?.photo == null)
                    ? const Icon(Icons.person)
                    : ClipOval(
                        child: Image.memory(imageBytes,
                            fit: BoxFit.cover, height: 80, width: 80))),
        title: Text(fullName(controller),
            style: const TextStyle(color: Colors.white)),
        subtitle: Text(controller.user!.email ?? '',
            style: const TextStyle(color: Colors.white)),
        trailing: enableOnTap
            ? IconButton(
                onPressed: () async {
                  await AuthController.clearAuthData();
                  Get.offAll(const LoginScreen());
                },
                icon: const Icon(Icons.logout, color: Colors.red))
            : null,
        onTap: () {
          if (enableOnTap) {
            Get.to(const UpdateProfileScreen());
          }
        },
      );
    });
  }

  String fullName(AuthController controller) {
    return "${controller.user!.firstName ?? ''} ${controller.user!.lastName ?? ''}";
  }
}
