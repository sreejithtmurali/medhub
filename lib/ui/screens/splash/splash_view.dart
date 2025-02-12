import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onViewModelReady: (model) => model.navigatelogin(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Color(0xff5272ff),
          body: Center(child: Assets.images.logo.image( height: 100,width: 100,fit: BoxFit.fill)),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
