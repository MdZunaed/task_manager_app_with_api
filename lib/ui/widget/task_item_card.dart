import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

class TaskItemCard extends StatelessWidget {
  final Task task;

  const TaskItemCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text(task.description ?? '',
                style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text("date: ${task.createdDate}"),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                    label: Text(task.status ?? 'New',
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.lightBlue),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit_note)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
