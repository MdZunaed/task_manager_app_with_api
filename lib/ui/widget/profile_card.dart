import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/edit_profile.dart';
import 'package:task_manager/ui/screen/login_screen.dart';

class ProfileCard extends StatefulWidget {
  final bool enableOnTap;

  const ProfileCard({super.key, this.enableOnTap = true});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes =
        const Base64Decoder().convert(AuthController.user?.photo ?? '');
    return ListTile(
      tileColor: Colors.green,
      leading: CircleAvatar(
          child: AuthController.user?.photo == ""
              ? const Icon(Icons.person)
              : ClipOval(
                  child: Image.memory(imageBytes,
                      fit: BoxFit.cover, height: 80, width: 80))),
      title: Text(fullName, style: const TextStyle(color: Colors.white)),
      subtitle: Text(AuthController.user!.email ?? '',
          style: const TextStyle(color: Colors.white)),
      trailing: widget.enableOnTap
          ? IconButton(
              onPressed: () async {
                await AuthController.clearAuthData();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout, color: Colors.red))
          : null,
      onTap: () {
        if (widget.enableOnTap) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
    );
  }

  String get fullName {
    return "${AuthController.user!.firstName ?? ''} ${AuthController.user!.lastName ?? ''}";
  }
}
