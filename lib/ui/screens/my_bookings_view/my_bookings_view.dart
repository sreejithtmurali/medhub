import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'my_bookings_view_model.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyBookingsViewModel>.reactive(
      viewModelBuilder: () => MyBookingsViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('My Bookings',style: TextStyle(color: Colors.white),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.navigateToAddBooking();
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add,color: Colors.white,),
        ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : _buildBookingsList(viewModel),
      ),
    );
  }

  Widget _buildBookingsList(MyBookingsViewModel viewModel) {
    if (viewModel.bookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to create a new booking',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.bookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final booking = viewModel.bookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(Booking booking) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Dr. ${booking.doctorName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.category,
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.confirmation_number, 'Booking ID: ${booking.bookingId}'),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.calendar_today,
              'Date: ${DateFormat('EEE, MMM d, yyyy').format(booking.bookingDate)}',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Time: ${booking.time}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade300),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
                // const SizedBox(width: 8),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //   ),
                //   child: const Text('Reschedule',style: TextStyle(color: Colors.white),),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade800),
        ),
      ],
    );
  }
}