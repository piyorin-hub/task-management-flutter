import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            task.isDone ? Icons.check_circle : Icons.check_circle_outline,
            color: task.isDone ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(
            task.title,
            style: TextStyle(
              fontWeight: task.isDone ? FontWeight.bold : FontWeight.normal,
              color: task.isDone ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
