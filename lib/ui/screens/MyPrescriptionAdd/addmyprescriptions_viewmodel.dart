import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../app/utils.dart';

class AddMyPrescriptionsModel extends BaseViewModel {
  final ImagePicker picker = ImagePicker();
  XFile? image, prescription;
  Future<XFile?> pickimage() async {
    if (Permission.camera.isDenied == true) {
      await Permission.camera.request();
    }
    var picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      return picked;
    }
  }



}
