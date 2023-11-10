import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/edit_profile.dart';

class ProfileCard extends StatelessWidget {
  final bool enableOnTap;

  const ProfileCard({super.key, this.enableOnTap = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.green,
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text("Name here", style: TextStyle(color: Colors.white)),
      subtitle: Text("email here", style: TextStyle(color: Colors.white)),
      trailing: enableOnTap
          ? const Icon(Icons.arrow_forward, color: Colors.white)
          : null,
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
    );
  }
}
