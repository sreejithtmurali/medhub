import 'package:flutter/material.dart';
import 'package:medhub/models/getalldoctors/Data.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../../models/allbookings/GetAllBookings.dart';
import '../../tools/screen_size.dart';
import 'home_viewmodel.dart';
import 'package:medhub/models/hospitalall/Data.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar

                    const SizedBox(height: 16),

                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search doctor by name...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Today's Appointments
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today Appointments',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Appointment Cards
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(16),
                        itemCount: model.mybookings!.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final booking = model.mybookings![index];
                          return _buildBookingCard(booking,model);
                        },
                      )
                    ),
                    const SizedBox(height: 24),

                    // Doctor Speciality

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       'Doctor Specialty',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: const Text('See all'),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    //
                    // // Specialty Grid

                    const SizedBox(height: 16),

                    // Popular Doctors

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Doctors',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            model.navdoctorlist();
                          },
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: model.doctorslist!.length > 2
                          ? 2
                          : model.doctorslist!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildDoctorCard(
                          model,
                          model.doctorslist![index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 12);
                      },
                    ),

                    // Doctor List

                    const SizedBox(height: 24),

                    // Popular Doctors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Hospitals',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            model.navhospitallist();
                          },
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Doctor List
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: model.hospitallist!.length >= 2
                          ? 2
                          : model.hospitallist!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildHospitalCard(
                            model, model.hospitallist![index]!);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 12);
                      },
                    ),

                    const SizedBox(height: 12),
                    // _buildHospitalCard(
                    //   model,
                    //   'Corparative Hospital',
                    //   'Multi Speciality Hospital',
                    //   '4.9',
                    //   'Kakkanad,kerala',
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  // Widget _buildAppointmentCard(
  //     BuildContext context, String doctorName, String type, String status) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width - 100,
  //     margin: const EdgeInsets.only(right: 12),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey[300]!),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             const CircleAvatar(
  //               radius: 16,
  //               backgroundColor: Colors.blue,
  //               child: Icon(Icons.person, color: Colors.white, size: 20),
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: Column(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       doctorName,
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       "Pediatric",
  //                       style: const TextStyle(
  //                         fontSize: 10,
  //                         fontWeight: FontWeight.normal,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             "BookingID: #1234",
  //             style: const TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             "Booking Date: 12/10/2025- 11:10 AM",
  //             style: const TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.normal,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 4),
  //         Row(
  //           children: [
  //             Text(
  //               "Status: ",
  //               style: const TextStyle(
  //                   fontSize: 10,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black),
  //             ),
  //             Text(
  //               "Pending",
  //               style: const TextStyle(
  //                   fontSize: 10,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.blue),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSpecialtyItem(String title, IconData icon, Color color) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard(HomeViewModel model, Hospital hospital) {
    return InkWell(
      onTap: () {
        model.navhospital(hospital);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${model.baseUrl}${hospital.image}"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${hospital.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${hospital.rating}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    "${hospital.about}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "${hospital.location}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "View",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(HomeViewModel model, Doctor doctor) {
    return InkWell(
      onTap: () {
        model.navdoctor(doctor);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage("${model.baseUrl}${doctor.image}"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${doctor.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${doctor.rating}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${doctor.department}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_hospital,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "${doctor.hospitalName}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Appoiment",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBookingCard(GetAllBookings booking, HomeViewModel viewModel) {
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
                  '${booking.doctor!.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${booking.doctor!.department}',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.confirmation_number, 'Booking ID: ${booking.id}'),
          const SizedBox(height: 8),
          _buildInfoRow(
            Icons.calendar_today,
            'Date: ${booking.selectedDate}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time, 'Time: ${booking.selectedTime}'),
          const SizedBox(height: 16),

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
