import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhub/models/allbookings/GetAllBookings.dart';
import 'package:stacked/stacked.dart';

import '../../../models/allnoti/Data.dart';
import 'my_noti_view_model.dart';

class NotifictionsView extends StatelessWidget {
  const NotifictionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotifictionsViewModel>.reactive(
      viewModelBuilder: () => NotifictionsViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, viewModel, child) => Scaffold(

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     viewModel.navigateToAddBooking();
        //   },
        //   backgroundColor: Colors.blue,
        //   child: const Icon(Icons.add,color: Colors.white,),
        // ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : _buildBookingsList(viewModel),
        floatingActionButton: FloatingActionButton(onPressed: (){
    viewModel.initialize();
    }, child: Icon(Icons.refresh,),
      ))
    );
  }

  Widget _buildBookingsList(NotifictionsViewModel viewModel) {
    if (viewModel.notifications!.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Notifications found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the reload button  to reload notifications',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: (){
        return viewModel.initialize();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.notifications!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final booking = viewModel.notifications![index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("${index+1}",style: TextStyle(color: Colors.white),),
            ),
            title: Text("${booking.message}"),
          );
        },
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