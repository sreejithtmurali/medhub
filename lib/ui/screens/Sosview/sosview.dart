import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/Sosview/sosviewmodel.dart';
import 'package:stacked/stacked.dart';

class SOSView extends StatelessWidget {
  const SOSView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SOSViewModel>.reactive(
      viewModelBuilder: () => SOSViewModel(),
      builder: (context, model, child) => Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          model.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      if (model.errorMessage!.contains('settings'))
                        TextButton(
                          onPressed: () => model.errorMessage!.contains('permanently')
                              ? model.openAppSettings()
                              : model.openLocationSettings(),
                          child: const Text('Open Settings'),
                        ),
                    ],
                  ),
                ),
              _buildEmergencyButton(
                'Emergency Call',
                Icons.phone_enabled,
                model.makeEmergencyCall,
                model.isBusy,
              ),
              const SizedBox(height: 20),
              _buildEmergencyButton(
                'Call Ambulance',
                Icons.local_hospital,
                model.callAmbulance,
                model.isBusy,
              ),
              const SizedBox(height: 20),
              _buildEmergencyButton(
                'Share Location with Medical Report',
                Icons.share_location,
                model.shareLocationWithMedicalHistory,
                model.isBusy,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(
      String label,
      IconData icon,
      VoidCallback onPressed,
      bool isBusy,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: isBusy
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isBusy ? null : onPressed,
      ),
    );
  }
}