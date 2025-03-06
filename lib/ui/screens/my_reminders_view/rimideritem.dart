import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/reminder.dart';

class ReminderListItem extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onDelete;

  const ReminderListItem({
    Key? key,
    required this.reminder,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          reminder.message,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Time: ${_formatTime(reminder.time)} - ${reminder.isPeriodic ? "Periodic" : "One-time"}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Date: ${_formatDate(reminder.fromDate)}${reminder.toDate != null ? " to ${_formatDate(reminder.toDate!)}" : ""}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        leading: _getPriorityIcon(reminder.priority),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        isThreeLine: true,
      ),
    );
  }

  Widget _getPriorityIcon(ReminderPriority priority) {
    IconData iconData;
    Color iconColor;

    switch (priority) {
      case ReminderPriority.low:
        iconData = Icons.low_priority;
        iconColor = Colors.green;
        break;
      case ReminderPriority.medium:
        iconData = Icons.priority_high;
        iconColor = Colors.orange;
        break;
      case ReminderPriority.high:
        iconData = Icons.priority_high;
        iconColor = Colors.red;
        break;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.2),
      child: Icon(iconData, color: iconColor),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}