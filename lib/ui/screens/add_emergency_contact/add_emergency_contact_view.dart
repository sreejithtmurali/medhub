import 'package:flutter/material.dart';
import 'package:medhub/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'add_emergency_contact_view_model.dart';

class AddEmergencyContactView extends StatelessWidget {
  const AddEmergencyContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEmergencyContactViewModel>.reactive(
      viewModelBuilder: () => AddEmergencyContactViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
           navigationService.popRepeated(1);
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: Colors.blue,
          title: const Text('Add Emergency Contact',style: TextStyle(color: Colors.white),),
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name field
                    TextFormField(
                      controller: viewModel.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => viewModel.validateName(value),
                    ),
                    const SizedBox(height: 16),

                    // Relationship field
                    TextFormField(
                      controller: viewModel.relationshipController,
                      decoration: const InputDecoration(
                        labelText: 'Relationship *',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. Parent, Spouse, Sibling',
                      ),
                      validator: (value) => viewModel.validateRelationship(value),
                    ),
                    const SizedBox(height: 16),

                    // Phone number field
                    TextFormField(
                      controller: viewModel.phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number *',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. +1 (123) 456-7890',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => viewModel.validatePhone(value),
                    ),
                    const SizedBox(height: 16),

                    // Email field (optional)
                    TextFormField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email (Optional)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. contact@example.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => viewModel.validateEmail(value),
                    ),
                    const SizedBox(height: 16),

                    // Priority dropdown
                    DropdownButtonFormField<int>(
                      value: viewModel.selectedPriority,
                      decoration: const InputDecoration(
                        labelText: 'Priority *',
                        border: OutlineInputBorder(),
                      ),
                      items: [1, 2, 3].map((priority) {
                        return DropdownMenuItem<int>(
                          value: priority,
                          child: Text('$priority ${viewModel.getPriorityLabel(priority)}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.selectedPriority = value!;
                        viewModel.notifyListeners();
                      },
                      validator: (value) => value == null ? 'Please select priority' : null,
                    ),
                    const SizedBox(height: 32),

                    // Save button
                    ElevatedButton(
                      onPressed: viewModel.isBusy
                          ? null
                          : () => viewModel.saveContact(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                      ),
                      child: viewModel.isBusy
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'SAVE CONTACT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}