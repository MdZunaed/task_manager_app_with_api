import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;
  final Color statusBgColor;


  const TaskItemCard({super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress, this.statusBgColor = Colors.lightBlue});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTask() async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.deleteTask(widget.task.sId ?? ''));
    if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, "Task deleted");
      }
      widget.onStatusChange();
      widget.showProgress(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.title ?? '',
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text(widget.task.description ?? '',
                style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text("date: ${widget.task.createdDate}"),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                    label: Text(widget.task.status ?? 'New',
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: widget.statusBgColor),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: deleteTask,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: showUpdateStatusModal,
                        icon: const Icon(Icons.edit_note)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) =>
        ListTile(
          title: Text(e.name),
          onTap: () {
            updateTaskStatus(e.name);
            Navigator.pop(context);
          },
        ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
          );
        });
  }
}
