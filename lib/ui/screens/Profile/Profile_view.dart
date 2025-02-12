import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';

import 'Profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(

      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: model.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar


                    // Profile Section
                    const Text(
                      'Complete your Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Access to our features and secure healthcare',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Profile Picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Form Fields
                    _buildTextField('Full Name', Icons.person_outline,model.uname),
                    const SizedBox(height: 16),

                    _buildTextField('Email', Icons.email_outlined,model.email),
                    const SizedBox(height: 16),
                    _buildTextField('phone', Icons.phone,model.email),
                    const SizedBox(height: 16),

                    // Date and Gender Row
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (v){
                              return v!.length==0?"Must enter DOB":null;
                            },
                            controller: model.dateController,
                            readOnly: true,
                            onTap: () => _selectDate(context,model),
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: model.selectedGender,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: ['Male', 'Female', 'Other']
                                .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                                .toList(),
                            onChanged: (value) {
                              model.selectedGender=value;
                              model.notifyListeners();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        model.login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.note_add_outlined,color: Colors.blue,),
                        TextButton(onPressed: (){
                          model.navigatePrescrip();
                        }, child: Text("My Prescription",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.medical_information_outlined,color: Colors.blue,),
                        TextButton(onPressed: (){
                          model.nevmedications();
                        }, child: Text("My Medications",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.sos,color: Colors.blue,),
                        TextButton(onPressed: (){}, child: Text("My Emergency Contacts",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.notes,color: Colors.blue,),
                        TextButton(onPressed: (){}, child: Text("My Bookings",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,color: Colors.blue,),
                        TextButton(onPressed: (){}, child: Text("My Reminders",style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.delete,color: Colors.red,),
                        TextButton(onPressed: (){}, child: Text("Delete My Account",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),)),
                      ],
                    ),
                 ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
  Widget _buildTextField(String label, IconData icon, TextEditingController ctlr) {
    return TextFormField(
      controller: ctlr,
      validator: (v){
        return v!.length==0?"Must fill $label":null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, ProfileViewModel model) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {

        model.dateController.text = "${picked.day}/${picked.month}/${picked.year}";
        model.notifyListeners();

    }
  }
}
