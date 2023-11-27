import 'package:flutter/material.dart';

import '../widget/profile_card.dart';
import '../widget/summary_card.dart';
import '../widget/task_item_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileCard(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                // return const TaskItemCard();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
