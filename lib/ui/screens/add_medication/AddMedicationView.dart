import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../services/medicationservice.dart';
import 'add_medication_view_model.dart';

class AddMedicationView extends StatelessWidget {
  const AddMedicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMedicationViewModel>.reactive(
      viewModelBuilder: () => AddMedicationViewModel(
        navigationService: locator<NavigationService>(),
        medicationService: locator<MedicationService>(),
      ),
      builder: (context, viewModel, child) => Scaffold(
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
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Medication Name',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter medication name';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.name = value!,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => viewModel.selectDate(context, true),
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Start Date',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Text(
                                      viewModel.startDate == null
                                          ? 'Select Start Date'
                                          : DateFormat('dd/MM/yyyy')
                                          .format(viewModel.startDate!),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InkWell(
                                  onTap: () => viewModel.selectDate(context, false),
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'End Date',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Text(
                                      viewModel.endDate == null
                                          ? 'Select End Date'
                                          : DateFormat('dd/MM/yyyy')
                                          .format(viewModel.endDate!),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Time Interval'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter time interval';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.timeInterval = value!,
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Take After Food'),
                            value: viewModel.afterFood,
                            onChanged: viewModel.toggleAfterFood,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  )
                              ),
                              onPressed: () => viewModel.saveMedication(context),
                              child: const Text('Add Medication',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),

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

                    // Upload Button
                    if (viewModel.hasMedications)
                      Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          onPressed: viewModel.isUploading ? null : viewModel.uploadMedications,
                          icon: const Icon(Icons.cloud_upload,color: Colors.white,),
                          label: Text(
                            viewModel.isUploading
                                ? 'Uploading...'
                                : 'Upload Medications',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    viewModel.hasMedications
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
                                  onPressed: () => viewModel.deleteMedication(medication.id!),
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
            if (viewModel.isUploading)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Uploading Medications...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}