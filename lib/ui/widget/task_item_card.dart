import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("title",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text("description", style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text("date"),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                    label: Text("status",
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
