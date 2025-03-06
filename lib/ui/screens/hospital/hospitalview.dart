import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhub/models/getalldoctors/Data.dart';
import 'package:medhub/models/hospitalall/Data.dart';
import 'package:stacked/stacked.dart';

import 'hospitalviewmodel.dart';

class HospitalDetailView extends StatelessWidget {
  Hospital hospital;
   HospitalDetailView({required this.hospital}) ;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HospitalDetailViewModel>.reactive(
      viewModelBuilder: () => HospitalDetailViewModel(hospital:hospital ),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        if (model.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context, model),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHospitalInfo(model),
                    _buildFacilities(model),
                    _buildAboutSection(model),
                    _buildDoctorsHeader(),
                  ],
                ),
              ),
              _buildDoctorsList(model),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, HospitalDetailViewModel model) {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          "${model.baseUrl}${model.hospital!.image}",
          fit: BoxFit.fill,
        ),
      ),
      leading:    IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

    );
  }

  Widget _buildHospitalInfo(HospitalDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${model.hospital!.name}",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 20),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                 "${model.hospital!.location}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '${model.hospital!.rating}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFacilities(HospitalDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Facilities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (model.hospital?.facilities != null && model.hospital!.facilities!.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: model.hospital!.facilities!.map((facility) {
                return Chip(
                  label: Text(facility.facility ?? 'No facility name'),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            )
          else
            const Text('No facilities available'),
        ],
      ),
    );
  }

  Widget _buildAboutSection(HospitalDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${model.hospital!.about}",
            style: const TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsHeader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Our Doctors',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDoctorsList(HospitalDetailViewModel model) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(

        delegate: SliverChildBuilderDelegate(

          (context, index) {
            final doctor = model.hospital!.doctors![index];
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(width: .2),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => model.navigateToDoctorDetail(doctor!),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image:
                                    NetworkImage('${model.baseUrl}${doctor.image}'),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${doctor.name}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${doctor.department}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${doctor.rating}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 55,
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
                              "Appoiment",
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
              ),
            );
          },
          childCount: model.hospital!.doctors!.length,
        ),
      ),
    );
  }
}
