import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String count, title;

  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        child: Column(
          children: [
            Text(count, style: Theme.of(context).textTheme.titleLarge),
            Text(title),
          ],
        ),
      ),
    );
  }
}
