import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../services/api_service.dart';
import 'Profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: (){
                return model.init();
              },
                  child: SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Form(
                  key: model.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            // Profile image
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: _buildProfileImage(model),
                              ),
                            ),

                            // Edit button
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => model.showImageSourceDialog(),
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form Fields
                      _buildTextField('Full Name', Icons.person_outline, model.uname,false),
                      const SizedBox(height: 16),

                      _buildTextField('Email', Icons.email_outlined, model.email,true),
                      const SizedBox(height: 16),

                      _buildTextField('Phone', Icons.phone, model.phone,false),
                      const SizedBox(height: 16),

                      // Date and Gender Row
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (v) {
                                return v!.isEmpty ? "Must enter DOB" : null;
                              },
                              controller: model.dateController,
                              readOnly: true,
                              onTap: () => _selectDate(context, model),
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
                                model.selectedGender = value;
                                model.notifyListeners();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Update Profile Button
                      ElevatedButton(
                        onPressed: () {
                          model.update();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: model.isBusy
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Menu Items
                      _buildMenuItem(
                        Icons.note_add_outlined,
                        "My Prescription",
                        Colors.blue,
                            () => model.navigatePrescrip(),
                      ),
                      _buildMenuItem(
                        Icons.medical_information_outlined,
                        "My Medications",
                        Colors.blue,
                            () => model.nevmedications(),
                      ),
                      _buildMenuItem(
                        Icons.sos,
                        "My Emergency Contacts",
                        Colors.blue,
                            () => model.nevemergency(),
                      ),
                      _buildMenuItem(
                        Icons.notes,
                        "My Bookings",
                        Colors.blue,
                            () => model.nevbookings(),
                      ),
                      _buildMenuItem(
                        Icons.timer_outlined,
                        "My Reminders",
                        Colors.blue,
                            () => model.nevreminder(),
                      ),
                      _buildMenuItem(
                        Icons.power_settings_new_sharp,
                        "Logout",
                        Colors.red,
                            () => model.logout(),
                      ),
                      _buildMenuItem(
                        Icons.delete,
                        "Delete My Account",
                        Colors.red,
                            () {},
                      ),
                    ],
                  ),
                                ),
                              ),
                ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }

  // Helper method to build profile image
  Widget _buildProfileImage(ProfileViewModel model) {
    if (model.profileImageFile != null) {
      // Show selected image
      return Image.file(
        model.profileImageFile!,
        fit: BoxFit.cover,
      );
    } else if (model.user?.image != null) {
      // Show image from URL
      return CachedNetworkImage(
        imageUrl: model.user?.image,
        // imageUrl: model.url!,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.person,
          size: 50,
          color: Colors.grey,
        ),
      );
    } else {
      // Show default icon
      return Container(
        color: Colors.grey[200],
        child: const Icon(
          Icons.person,
          size: 50,
          color: Colors.grey,
        ),
      );
    }
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, IconData icon, TextEditingController ctlr,bool?editable) {
    return TextFormField(
      readOnly: editable??false,
      controller: ctlr,
      validator: (v) {
        return v!.isEmpty ? "Must fill $label" : null;
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

  // Helper method to build menu items
  Widget _buildMenuItem(IconData icon, String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date picker
  Future<void> _selectDate(BuildContext context, ProfileViewModel model) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      model.dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      model.notifyListeners();
    }
  }
}