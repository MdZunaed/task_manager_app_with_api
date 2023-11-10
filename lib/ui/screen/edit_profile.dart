import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/profile_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileCard(
              enableOnTap: false,
            ),
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
                      decoration: const InputDecoration(hintText: "Email")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration:
                          const InputDecoration(hintText: "First Name")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Last Name")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Mobile")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Password")),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Save"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }

  Container photoPicker() {
    return Container(
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
          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }
}
