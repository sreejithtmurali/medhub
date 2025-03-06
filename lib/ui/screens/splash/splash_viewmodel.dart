import 'dart:async';

import 'package:medhub/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class SplashViewModel extends BaseViewModel {
  Timer? _timer;



  init() async {


    startTimer();

  }
  void startTimer() async {

    _timer = Timer(const Duration(seconds: 1), () async {
      print('Navigate to next  screen');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool s= prefs.getBool("is_logged_in") ?? false;
      if(s){
        navigationService.pushNamedAndRemoveUntil(
            Routes.dashboardview);
      }
      else{
        navigationService.pushNamedAndRemoveUntil(Routes.loginView);
      }
    });
  }

  @override
  void dispose() {
    print('Timer cancelled');
    _timer?.cancel();
    super.dispose();
  }


}
