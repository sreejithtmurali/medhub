import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/home/home_view.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';
import 'dashboardviewmodel.dart';

class Dashboardview extends StatelessWidget {
  const Dashboardview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardviewModel>.reactive(
      // onViewModelReady: (model) => model.navigatelogin(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(),
            ),
            title: Text("Hai Sreejith...",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.white,))],
          ),
          body: model.pages[model.current],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (i){
              model.updateCurrent(i);
            },
            currentIndex: model.current,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.sos), label: 'Emergency'),
            ],
          ),
        );
      },
      viewModelBuilder: () => DashboardviewModel(),
    );
  }
}
