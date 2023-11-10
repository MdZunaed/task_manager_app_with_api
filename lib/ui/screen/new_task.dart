import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/widget/profile_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

import '../widget/summary_card.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewTaskScreen()));
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileCard(),
              const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      SummaryCard(count: "9", title: "New"),
                      SummaryCard(count: "9", title: "In Progress"),
                      SummaryCard(count: "9", title: "Completed"),
                      SummaryCard(count: "9", title: "Cancelled"),
                    ],
                  )),
              Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const TaskItemCard();
                      }))
            ],
          ),
        ));
  }
}
