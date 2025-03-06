import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/getalldoctors/Data.dart';
import '../../../models/getalldoctors/Timeslots.dart';
import 'doctor_viewmodel.dart';

class DoctorView extends StatelessWidget {
  final Doctor? doctor;

  const DoctorView({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoctorViewModel>.reactive(
      viewModelBuilder: () => DoctorViewModel(doctor: doctor),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, model),
                _buildDoctorInfo(model),
                _buildMetrics(model),
                _buildAboutSection(model),
                _buildDatePickerSection(model,context),
                _buildVisitHourSection(model),
                _buildAppointmentButton(context, model),
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
          child: model.doctorImageUrl != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              model.doctorImageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[500],
                    size: 100,
                  ),
                );
              },
            ),
          )
              : Center(
            child: Icon(
              Icons.person,
              color: Colors.grey[500],
              size: 100,
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
                model.getDoctorName(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${model.getDoctorRating()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            model.getDoctorDepartment(),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildMetricItem(
            icon: Icons.work,
            value: '${model.getDoctorExperience()}+',
            label: 'Years',
          ),
          const SizedBox(width: 30),
          _buildMetricItem(
            icon: Icons.star,
            value: model.getDoctorRating().toString(),
            label: 'Rating',
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
            model.getDoctorAbout(),
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

  Widget _buildDatePickerSection(DoctorViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => model.selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.blue),
                  const SizedBox(width: 16),
                  Text(
                    model.selectedDate != null
                        ? '${model.selectedDate!.day}/${model.selectedDate!.month}/${model.selectedDate!.year}'
                        : 'Select a date',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHourSection(DoctorViewModel model) {
    return Padding(
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
    );
  }

  Widget _buildTimeSlots(DoctorViewModel model) {
    List<Timeslots> availableSlots = model.doctor?.timeslots ?? [];

    if (availableSlots.isEmpty) {
      return Center(
        child: Text(
          'No time slots available',
          style: TextStyle(color: Colors.grey[600]),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 16,
      children: availableSlots.map((slot) => _buildTimeSlot(slot, model)).toList(),
    );
  }

  Widget _buildTimeSlot(Timeslots slot, DoctorViewModel model) {
    String time = slot.slot ?? 'N/A';
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

  Widget _buildAppointmentButton(BuildContext context, DoctorViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: model.isBooking ? null : () => model.bookNow(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: model.isBooking
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// import '../../../models/getalldoctors/Data.dart';
// import '../../../models/getalldoctors/Timeslots.dart';
// import 'doctor_viewmodel.dart';
//
// class DoctorView extends StatelessWidget {
//   final Doctor? doctor;
//
//   const DoctorView({Key? key, required this.doctor}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<DoctorViewModel>.reactive(
//       viewModelBuilder: () => DoctorViewModel(doctor: doctor),
//       builder: (context, model, child) => Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(context, model),
//                 _buildDoctorInfo(model),
//                 _buildMetrics(model),
//                 _buildAboutSection(model),
//                 _buildVisitHourSection(model),
//                 _buildAppointmentButton(context, model),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(BuildContext context, DoctorViewModel model) {
//     return Stack(
//       children: [
//         Container(
//           height: 240,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.grey[200],
//           ),
//           margin: const EdgeInsets.all(16),
//           child: model.doctorImageUrl != null
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(
//               model.doctorImageUrl!,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Center(
//                   child: Icon(
//                     Icons.person,
//                     color: Colors.grey[500],
//                     size: 100,
//                   ),
//                 );
//               },
//             ),
//           )
//               : Center(
//             child: Icon(
//               Icons.person,
//               color: Colors.grey[500],
//               size: 100,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 24,
//           left: 24,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDoctorInfo(DoctorViewModel model) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 model.getDoctorName(),
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Spacer(),
//               const Icon(Icons.star, color: Colors.amber, size: 20),
//               const SizedBox(width: 4),
//               Text(
//                 '${model.getDoctorRating()}',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             model.getDoctorDepartment(),
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMetrics(DoctorViewModel model) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           _buildMetricItem(
//             icon: Icons.work,
//             value: '${model.getDoctorExperience()}+',
//             label: 'Years',
//           ),
//           const SizedBox(width: 30),
//           _buildMetricItem(
//             icon: Icons.star,
//             value: model.getDoctorRating().toString(),
//             label: 'Rating',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMetricItem({
//     required IconData icon,
//     required String value,
//     required String label,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.blue, size: 24),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAboutSection(DoctorViewModel model) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'About Me',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             model.getDoctorAbout(),
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildVisitHourSection(DoctorViewModel model) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Visit Hour',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildTimeSlots(model),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimeSlots(DoctorViewModel model) {
//     List<Timeslots> availableSlots = model.doctor?.timeslots ?? [];
//
//     if (availableSlots.isEmpty) {
//       return Center(
//         child: Text(
//           'No time slots available',
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//       );
//     }
//
//     return Wrap(
//       spacing: 8,
//       runSpacing: 16,
//       children: availableSlots.map((slot) => _buildTimeSlot(slot, model)).toList(),
//     );
//   }
//
//   Widget _buildTimeSlot(Timeslots slot, DoctorViewModel model) {
//     String time = slot.slot ?? 'N/A';
//     bool isSelected = model.selectedTimeSlot == time;
//
//     return GestureDetector(
//       onTap: () => model.setSelectedTimeSlot(time),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue : Colors.white,
//           border: Border.all(color: isSelected ? Colors.blue : Colors.grey[300]!),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           time,
//           style: TextStyle(
//             fontSize: 14,
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppointmentButton(BuildContext context, DoctorViewModel model) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ElevatedButton(
//         onPressed: () {
//           if (model.selectedTimeSlot != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Appointment booked at ${model.selectedTimeSlot}'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Please select a time slot'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           minimumSize: const Size(double.infinity, 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: const Text(
//           'Book Appointment',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }