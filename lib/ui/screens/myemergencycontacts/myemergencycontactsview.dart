import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import 'my_emergency_contact_view_model.dart';

class MyEmergencyContactView extends StatelessWidget {
  const MyEmergencyContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEmergencyContactViewModel>.reactive(
      viewModelBuilder: () => MyEmergencyContactViewModel(),
      onViewModelReady: (model){
        model.init();
      },
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            viewModel.navigateToAddContact();
          },
          child: Icon(Icons.add,color: Colors.white,),
        ),
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          backgroundColor: Colors.blue,
          title: const Text('Emergency Contacts',style: TextStyle(color: Colors.white),),
          actions: [IconButton(onPressed: (){
          viewModel.init();
          }, icon: Icon(Icons.restart_alt,color: Colors.white,))],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  viewModel.emergencyContacts!.isNotEmpty
                      ? Expanded(
                    child: ListView.separated(
                      itemCount: viewModel.emergencyContacts!.length,
                      separatorBuilder: (context, index) => SizedBox(height: 5,),
                      itemBuilder: (context, index) {
                        final contact = viewModel.emergencyContacts![index];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],

                            borderRadius: BorderRadius.circular(10)
                               
                          ),
                          child: Row(
                            children: [
                              // Contact details section
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${contact.name}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Relationship: ${contact.relationship}'),
                                    Text('Phone: ${contact.phone}'),
                                    if (contact.email != null && contact.email!.isNotEmpty)
                                      Text('Email: ${contact.email}'),
                                    Text('Priority: ${ viewModel.getPriorityLabel("${contact.priority}")}'),
                                  ],
                                ),
                              ),

                              // Action button (delete only)
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => viewModel.deleteContact(contact),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                      : const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Text('No emergency contacts added yet'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import '../../../app/app.locator.dart';
// import '../../../app/app.router.dart';
// import 'my_emergency_contact_view_model.dart';
//
// class MyEmergencyContactView extends StatelessWidget {
//   const MyEmergencyContactView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<MyEmergencyContactViewModel>.reactive(
//       viewModelBuilder: () => MyEmergencyContactViewModel(),
//       builder: (context, viewModel, child) => Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             viewModel.navigateToAddContact();
//           },
//           child: Text("Add"),
//         ),
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: const Text('Emergency Contacts'),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 24),
//
//                     // Emergency Contact List DataTable
//                     const Text(
//                       'Your Emergency Contacts',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//                     viewModel.emergencyContacts.length > 0
//                         ? SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         border: TableBorder(
//                             verticalInside: BorderSide(color: Colors.black),
//                             horizontalInside: BorderSide(color: Colors.black),
//                             left: BorderSide(color: Colors.black),
//                             right: BorderSide(color: Colors.black),
//                             bottom: BorderSide(color: Colors.black),
//                             top: BorderSide(color: Colors.black)),
//                         columns: const [
//                           DataColumn(label: Text('Name')),
//                           DataColumn(label: Text('Relationship')),
//                           DataColumn(label: Text('Phone Number')),
//                           DataColumn(label: Text('Email')),
//                           DataColumn(label: Text('Priority')),
//                           DataColumn(label: Text('Actions')),
//                         ],
//                         rows: viewModel.emergencyContacts.map((contact) {
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(contact.name)),
//                               DataCell(Text(contact.relationship)),
//                               DataCell(Text(contact.phoneNumber)),
//                               DataCell(Text(contact.email ?? '')),
//                               DataCell(Text(contact.priority.toString())),
//                               DataCell(
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.edit, color: Colors.blue),
//                                       onPressed: () => viewModel.editContact(contact),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () => viewModel.deleteContact(contact),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     )
//                         : const Center(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: 32.0),
//                         child: Text('No emergency contacts added yet'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }