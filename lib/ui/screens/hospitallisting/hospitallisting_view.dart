import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/hospital/hospitalviewmodel.dart';
import 'package:medhub/ui/screens/hospitallisting/hospitallist_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../models/hospitalall/Data.dart';


class HospitalsList extends StatelessWidget {
  const HospitalsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HospitalListModel>.reactive(
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            title: Text("Hospitals", style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      model.searchHospitals(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search hospital by name, location, or description...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.mic),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),

                // Hospitals List
                Expanded(
                  child: model.filteredHospitalsList! == null || model.filteredHospitalsList!.isEmpty
                      ? Center(
                    child: Text(
                      'No hospitals found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: model.filteredHospitalsList!.length,
                    itemBuilder: (context, index) {
                      final hospital = model.filteredHospitalsList![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildHospitalCard(model, hospital),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HospitalListModel(),
    );
  }

  Widget _buildHospitalCard(HospitalListModel model, Hospital hospital) {
    return InkWell(
      onTap: () {
        model.navhospital(hospital);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${model.baseUrl}${hospital.image}"),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${hospital.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${hospital.rating}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    maxLines: 1,
                    "${hospital.about}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "${hospital.location}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "View",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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