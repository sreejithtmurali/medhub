import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'add_booking_view_model.dart';

class AddBookingView extends StatelessWidget {
  const AddBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBookingViewModel>.reactive(
      viewModelBuilder: () => AddBookingViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('New Booking',style: TextStyle(color: Colors.white),),
        ),
        body: Form(
          key: viewModel.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Selection
                const Text(
                  'Select Doctor',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  value: viewModel.selectedDoctor,
                  items: viewModel.doctors.map((doctor) {
                    return DropdownMenuItem(
                      value: doctor,
                      child: Text('Dr. $doctor'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.selectedDoctor = value!;
                    viewModel.updateCategory();
                  },
                  validator: (value) => value == null ? 'Please select a doctor' : null,
                ),
                const SizedBox(height: 24),

                // Category (auto-filled based on doctor)
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: viewModel.categoryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 24),

                // Date Selection
                const Text(
                  'Select Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: viewModel.dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => viewModel.selectDate(context),
                  validator: (value) => value!.isEmpty ? 'Please select a date' : null,
                ),
                const SizedBox(height: 24),

                // Time Selection
                const Text(
                  'Select Time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  value: viewModel.selectedTime,
                  items: viewModel.availableTimes.map((time) {
                    return DropdownMenuItem(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.selectedTime = value!;
                  },
                  validator: (value) => value == null ? 'Please select a time' : null,
                ),
                const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: viewModel.isBusy ? null : () => viewModel.submitBooking(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: viewModel.isBusy
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'CONFIRM BOOKING',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
