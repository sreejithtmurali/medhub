import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class DoctorsListModel extends BaseViewModel {
  navigatelogin() {
    Timer(Duration(seconds: 4),()=>{
      navigationService.navigateTo(Routes.loginView)
    });
  }
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Jacob Jones',
      'rating': '4.8',
      'time': '10:00 AM-4:00 PM',
      'imageUrl': 'assets/doctor1.jpg',
    },
    {
      'name': 'Dr. Sabir Khan',
      'rating': '4.7',
      'time': '9:00 AM-3:00 PM',
      'imageUrl': 'assets/doctor2.jpg',
    },
    {
      'name': 'Dr. Kamala Ragimova',
      'rating': '4.9',
      'time': '10:30 AM-2:00 PM',
      'imageUrl': 'assets/doctor3.jpg',
    },
    {
      'name': 'Dr. Zorifa Shikhali',
      'rating': '4.8',
      'time': '11:00 AM-4:00 PM',
      'imageUrl': 'assets/doctor4.jpg',
    },
    {
      'name': 'Dr. Jenny Griffin Jones',
      'rating': '4.9',
      'time': '11:00 AM-4:30 PM',
      'imageUrl': 'assets/doctor5.jpg',
    },
    {
      'name': 'Dr. Jenny Griffin Jones',
      'rating': '4.7',
      'time': '10:00 AM-4:30 PM',
      'imageUrl': 'assets/doctor6.jpg',
    },
  ];

  void navdoctor() {
    navigationService.navigateTo(Routes.doctorView);
  }

}
