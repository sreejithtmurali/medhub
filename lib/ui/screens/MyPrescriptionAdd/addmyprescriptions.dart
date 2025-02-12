import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';
import 'AddMyPrescriptions_viewmodel.dart';


class AddMyPrescriptions extends StatelessWidget {
  const AddMyPrescriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMyPrescriptionsModel>.reactive(
      // onViewModelReady: (model) => model.navigatelogin(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("My Prescriptions",style: TextStyle(color: Color(0xffffffff)),),),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(child: Assets.images.prescription.image( height: ScreenSize.width/2,width: ScreenSize.width/2,fit: BoxFit.fill)),
                  InkWell(
                    onTap: () async {
                      var data = await model.pickimage();
                      if (data != null) {
            
                       model.prescription = data;
                       model.notifyListeners();
            
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: model.prescription == null
                          ? Center(
                          child: Icon(
                            Icons.note_alt_sharp,
                            size: 50,
                            color: Colors.blue,
                          ))
                          : Image.file(
                        File(model.prescription!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Upload your medical prescription    ",
                        style: TextStyle(color: Colors.blue),
                      )),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Doctor Name",
                      labelText: "Doctor Name",
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Date of Prescription",
                      labelText: "Date of Prescription",
                    ),
                  ),
                  SizedBox(height: 24,),
                  ElevatedButton(
                    onPressed: () {
            
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => AddMyPrescriptionsModel(),
    );
  }
}
