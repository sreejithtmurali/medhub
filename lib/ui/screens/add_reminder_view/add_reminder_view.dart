import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/reminder.dart';
import 'add_reminder_view_model.dart';


class AddReminderView extends StatelessWidget {
  final Reminder? reminderToEdit;

  const AddReminderView({Key? key, this.reminderToEdit}) : super(key: key);




  Widget _buildPriorityButton(
      BuildContext context,
      AddReminderViewModel viewModel,
      ReminderPriority priority,
      String label,
      Color color,
      ) {
    final isSelected = viewModel.priority == priority;
    return Expanded(
      child: InkWell(
        onTap: () => viewModel.setPriority(priority),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: isSelected ? color : Colors.grey,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                priority == ReminderPriority.low
                    ? Icons.arrow_downward
                    : priority == ReminderPriority.medium
                    ? Icons.remove
                    : Icons.arrow_upward,
                color: isSelected ? color : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(viewModelBuilder: () {
      return AddReminderViewModel();
    }, builder: (BuildContext context, AddReminderViewModel viewModel, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(reminderToEdit == null ? 'Add Reminder' : 'Edit Reminder'),
        ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reminder message input
                TextFormField(
                  controller: viewModel.messageController,
                  decoration: const InputDecoration(
                    labelText: 'Medication or Task',
                    hintText: 'Enter medication name or task description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a reminder message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Priority selection
                const Text(
                  'Priority:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPriorityButton(
                      context,
                      viewModel,
                      ReminderPriority.low,
                      'Low',
                      Colors.green,
                    ),
                    const SizedBox(width: 10),
                    _buildPriorityButton(
                      context,
                      viewModel,
                      ReminderPriority.medium,
                      'Medium',
                      Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    _buildPriorityButton(
                      context,
                      viewModel,
                      ReminderPriority.high,
                      'High',
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Time selection
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time),
                  title: const Text('Time'),
                  subtitle: Text(viewModel.formatTimeOfDay()),
                  onTap: () => viewModel.selectTime(context),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),

                // From date selection
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Start Date'),
                  subtitle: Text(viewModel.formatDate(viewModel.fromDate)),
                  onTap: () => viewModel.selectFromDate(context),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),

                // Periodic reminder toggle
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Recurring Reminder'),
                  subtitle: const Text(
                      'Set up a reminder that repeats daily until end date'),
                  value: viewModel.isPeriodic,
                  onChanged: viewModel.setIsPeriodic,
                  dense: true,
                ),
                const SizedBox(height: 16),

                // To date selection (only for periodic reminders)
                if (viewModel.isPeriodic)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.event),
                    title: const Text('End Date'),
                    subtitle: Text(viewModel.toDate != null
                        ? viewModel.formatDate(viewModel.toDate!)
                        : 'Select an end date'),
                    onTap: () => viewModel.selectToDate(context),
                    tileColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                const SizedBox(height: 32),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: viewModel.saveReminder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      reminderToEdit == null ? 'Save Reminder' : 'Update Reminder',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}