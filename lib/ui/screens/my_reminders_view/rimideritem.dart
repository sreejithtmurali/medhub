import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhub/models/allriminders/Data.dart';



class ReminderListItem extends StatelessWidget {
  final Riminder reminder;
  final VoidCallback onDelete;

  const ReminderListItem({
    Key? key,
    required this.reminder,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_information_outlined,color: Colors.lightBlueAccent,),
          ],
        ),
        title: Text(
          reminder!.message!,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Time: ${reminder!.time!} - ${reminder!.repeat==true?"Periodic" : "One-time"}  ',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Date: ${(reminder!.fromDate)}${reminder.toDate != null ? " to ${(reminder.toDate!)}" : ""}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        isThreeLine: true,
      ),
    );
  }

}