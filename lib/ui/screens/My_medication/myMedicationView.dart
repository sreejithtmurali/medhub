import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/medicationservice.dart';
import 'my_medication_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhub/app/app.router.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/medicationservice.dart';
import 'my_medication_view_model.dart';

class ViewAllMedications extends StatelessWidget {
  const ViewAllMedications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewAllMedicationsModel>.reactive(
      viewModelBuilder: () => ViewAllMedicationsModel(

      ),
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          navigationService.navigateTo(Routes.addMedicationView);
        },child: Text("Add"),),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Medication'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Add Medication Form (previous implementation)


                    const SizedBox(height: 24),

                    // Medication List DataTable
                    const Text(
                      'Existing Medications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),



                    viewModel.medications.length>0
                        ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder(
                            verticalInside:  BorderSide(color: Colors.black),
                            horizontalInside:  BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black)

                        ),
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Start Date')),
                          DataColumn(label: Text('End Date')),
                          DataColumn(label: Text('Interval')),
                          DataColumn(label: Text('After Food')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: viewModel.medications.map((medication) {
                          return DataRow(
                            cells: [
                              DataCell(Text(medication.name)),
                              DataCell(Text(
                                  DateFormat('dd/MM/yyyy').format(medication.startDate)
                              )),
                              DataCell(Text(
                                  DateFormat('dd/MM/yyyy').format(medication.endDate)
                              )),
                              DataCell(Text(medication.timeInterval)),
                              DataCell(Text(medication.afterFood ? 'Yes' : 'No')),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => viewModel.deleteMedication(medication!),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                        : const Center(child: Text('No medications added yet')),
                  ],
                ),
              ),
            ),

            // Loading Overlay

          ],
        ),
      ),
    );
  }
}
