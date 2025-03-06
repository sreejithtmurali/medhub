import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:medhub/ui/screens/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';
import 'addmyprescriptions_viewmodel.dart';



class AddMyPrescriptions extends StatelessWidget {
  const AddMyPrescriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMyPrescriptionsModel>.reactive(
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("My Prescriptions", style: TextStyle(color: Color(0xffffffff))),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                      child: Assets.images.prescription.image(
                          height: ScreenSize.width / 2,
                          width: ScreenSize.width / 2,
                          fit: BoxFit.fill
                      )
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      var data = await model.pickimage();
                      if (data != null) {
                        model.prescription = File(data.path);
                        model.notifyListeners();
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
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
                      )
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: model.doctorNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Doctor Name",
                      labelText: "Doctor Name",
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context, model),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date of Prescription",
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.selectedDate != null
                                ? DateFormat('dd-MM-yyyy').format(model.selectedDate!)
                                : "Select Date",
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: model.isLoading
                        ? null
                        : () => model.uploadPrescription(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: model.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (model.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        model.errorMessage,
                        style: TextStyle(color: Colors.red),
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

  Future<void> _selectDate(BuildContext context, AddMyPrescriptionsModel model) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: model!.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != model.selectedDate) {
      model.setSelectedDate(picked);
    }
  }
}