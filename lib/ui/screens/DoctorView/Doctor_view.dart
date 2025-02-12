import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/doctor.dart';
import 'doctor_viewmodel.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorViewModel>.reactive(
      viewModelBuilder: () => DoctorViewModel(),
      builder: (context, model, child) =>
          Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, model),
                    _buildDoctorInfo(model),
                    _buildMetrics(model),
                    _buildAboutSection(model),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Visit Hour',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTimeSlots(model),
                        ],
                      ),
                    ),
                
                
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (model.selectedTimeSlot != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Appointment booked at ${model
                                    .selectedTimeSlot}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a time slot'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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

  Widget _buildHeader(BuildContext context, DoctorViewModel model) {
    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              model.doctorsListModel.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Positioned(
          top: 24,
          right: 24,
          child: IconButton(
            icon: Icon(
              model.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: model.isFavorite ? Colors.red : null,
            ),
            onPressed: model.toggleFavorite,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInfo(DoctorViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                model.doctorsListModel.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${model.doctorsListModel.rating} (${model.doctorsListModel.reviews} reviews)',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            model.doctorsListModel.specialization,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrics(DoctorViewModel model) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricItem(
            icon: Icons.people,
            value: '${model.doctorsListModel.patients}+',
            label: 'Patients',
          ),
          _buildMetricItem(
            icon: Icons.work,
            value: '${model.doctorsListModel.experience}+',
            label: 'Years',
          ),
          _buildMetricItem(
            icon: Icons.star,
            value: model.doctorsListModel.rating.toString(),
            label: 'Rating',
          ),
          _buildMetricItem(
            icon: Icons.chat,
            value: '${model.doctorsListModel.reviews}+',
            label: 'Reviews',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(DoctorViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            model.doctorsListModel.about,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTimeSlots(DoctorViewModel model) {
    List<String> timeSlots = ['11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM'];

    return Wrap(
      spacing: 8,
      runSpacing: 16,
      children: timeSlots.map((time) => _buildTimeSlot(time, model)).toList(),
    );
  }

  Widget _buildTimeSlot(String time, DoctorViewModel model) {
    bool isSelected = model.selectedTimeSlot == time;

    return GestureDetector(
      onTap: () => model.setSelectedTimeSlot(time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
