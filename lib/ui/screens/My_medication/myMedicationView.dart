import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/medicationservice.dart';
import 'my_medication_view_model.dart';
import 'package:medhub/app/app.router.dart';
import 'package:medhub/app/utils.dart';

class ViewAllMedications extends StatelessWidget {
  const ViewAllMedications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewAllMedicationsModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ViewAllMedicationsModel(),
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            navigationService.navigateTo(Routes.addMedicationView);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)
          ),
          backgroundColor: Colors.blue,
          title: const Text('My Medication', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(onPressed: (){
              viewModel.init();
            }, icon: Icon(Icons.refresh,color: Colors.white,))
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Existing Medications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Null check and empty list handling
                    viewModel.medications.isEmpty
                        ? const Center(child: Text('No medications added yet'))
                        : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder(
                            verticalInside: const BorderSide(color: Colors.black),
                            horizontalInside: const BorderSide(color: Colors.black),
                            left: const BorderSide(color: Colors.black),
                            right: const BorderSide(color: Colors.black),
                            bottom: const BorderSide(color: Colors.black),
                            top: const BorderSide(color: Colors.black)
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
                              // Null-safe access with default values
                              DataCell(Text(medication.name ?? 'Unknown')),
                              DataCell(Text(
                                  medication.startDate != null
                                      ? DateFormat('dd/MM/yyyy').format(medication.startDate!)
                                      : 'N/A'
                              )),
                              DataCell(Text(
                                  medication.endDate != null
                                      ? DateFormat('dd/MM/yyyy').format(medication.endDate!)
                                      : 'N/A'
                              )),
                              DataCell(Text(medication.timeInterval?.toString() ?? 'N/A')),
                              DataCell(Text(medication.afterFood == true ? 'Yes' : 'No')),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => viewModel.deleteMedication(medication),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}