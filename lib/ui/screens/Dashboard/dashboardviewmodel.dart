import 'dart:async';

import 'package:medhub/ui/screens/home/home_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class DashboardviewModel extends BaseViewModel {
  var current=0;
  var pages=[HomeView(),HomeView(),HomeView(),HomeView()];

  navigatelogin() {
    Timer(Duration(seconds: 4),()=>{
      navigationService.navigateTo(Routes.loginView)
    });
  }

}
