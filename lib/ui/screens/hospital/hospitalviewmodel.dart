import 'package:medhub/app/app.router.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';

import '../../../models/hospital.dart';

class HospitalDetailViewModel extends BaseViewModel {
  Hospital? _hospital;
  List<Doctor> _doctors = [];
  bool _isLoading = true;

  Hospital? get hospital => _hospital;
  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _hospital = Hospital(
      id: '1',
      name: 'Christ Hospital',
      imageUrl: 'https://th.bing.com/th/id/OIP.F7bO0Knjtd29dC-g3qA-8wHaD2?w=672&h=350&rs=1&pid=ImgDetMain',
      address: '123 Medical Center Drive, London, UK',
      rating: 4.8,
      reviews: 524,
      about: 'One of the leading hospitals in London with state-of-the-art facilities and experienced medical professionals.',
      facilities: [
        'Emergency Care',
        'ICU',
        'Surgery',
        'Cardiology',
        'Neurology',
        'Pediatrics'
      ],
    );

    _doctors = [
      Doctor(
        id: '1',
        name: 'Dr. Ali Uzair',
        specialization: 'Cardiologist',
        imageUrl: 'https://www.bing.com/th?id=OLC.210iz5HO4SXVGA480x360&w=278&h=200&c=8&rs=1&qlt=80&p=0&cdv=1&pid=Local',
        rating: 4.9,
        reviews: 90,
      ),
      Doctor(
        id: '2',
        name: 'Dr. Sarah Smith',
        specialization: 'Neurologist',
        imageUrl: 'https://th.bing.com/th?id=OLC.Sl/QxfW2cvdulg480x360&rs=1&pid=ImgDetMain',
        rating: 4.7,
        reviews: 78,
      ),
      Doctor(
        id: '3',
        name: 'Dr. Sarah Smith',
        specialization: 'Neurologist',
        imageUrl: 'https://th.bing.com/th?id=OLC.Sl/QxfW2cvdulg480x360&rs=1&pid=ImgDetMain',
        rating: 4.7,
        reviews: 78,
      ),
      // Add more doctors as needed
    ];

    _isLoading = false;
    notifyListeners();
  }

  void navigateToDoctorDetail(String doctorId) {
    // Implement navigation
    print('Navigate to doctor: $doctorId');
    navigationService.navigateTo(Routes.doctorView);
  }
}
