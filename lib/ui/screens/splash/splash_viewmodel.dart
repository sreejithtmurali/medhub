import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class SplashViewModel extends BaseViewModel {
  navigatelogin() {
    Timer(Duration(seconds: 4),()=>{
      navigationService.navigateTo(Routes.loginView)
    });
  }

}
