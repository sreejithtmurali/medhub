import 'dart:async';
import 'package:medhub/ui/screens/Sosview/sosview.dart';
import 'package:medhub/ui/screens/home/home_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';
import '../Profile/Profile_view.dart';

class DashboardviewModel extends BaseViewModel {
  var current=0;
  var pages=[HomeView(),HomeView(),ProfileView(),SOSView()];

  navigatelogin() {
    Timer(Duration(seconds: 4),()=>{
      navigationService.navigateTo(Routes.loginView)
    });
  }

  void updateCurrent(int i) {
   current=i;
    notifyListeners();
  }

}
