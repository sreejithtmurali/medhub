// Import for Int64List
import 'dart:typed_data';

// views/my_reminders_view.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhub/ui/screens/my_reminders_view/rimideritem.dart';
import 'package:stacked/stacked.dart';
import '../../../models/reminder.dart';
import 'my_reminders_view_model.dart';

class MyRemindersView extends StatelessWidget {
  const MyRemindersView({Key? key}) : super(key: key);

// These functions should be added to the HomeView file

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyRemindersViewModel>.reactive(
        viewModelBuilder: () => MyRemindersViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, viewModel, child) =>
            Scaffold(
              appBar: AppBar(
                leading: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                backgroundColor: Colors.blue,
                title:  Text('My Reminders',style: TextStyle(color: Colors.white),),
              ),
              body: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.reminders!.isEmpty
                  ? const Center(child: Text('No reminders yet. Create one!'))
                  : ListView.builder(
                itemCount: viewModel.reminders!.length,
                itemBuilder: (context, index) {
                  final reminder = viewModel.reminders![index];
                  return ReminderListItem(
                    reminder: reminder,
                    onDelete: () => viewModel.deleteReminder(reminder!.id!),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: viewModel.navigateToAddReminder,
                child: const Icon(Icons.add,color: Colors.white,),
              ),
            ));
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

}