import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medhub/ui/screens/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';
import 'myprescriptions_viewmodel.dart';


class MyPrescriptions extends StatelessWidget {
  const MyPrescriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyPrescriptionsModel>.reactive(
       onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white)
            ),
            backgroundColor: Colors.blue,
            title: Text("Add Prescriptions",style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: (){
              model.init();
            }, icon: Icon(Icons.refresh,color: Colors.white,))
          ],),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(itemCount: model.mylist!.length, itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: .2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      child: Image.network("${model.baseUrl}${model.mylist![index].image}",width: double.maxFinite,height: 150,fit: BoxFit.cover,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${model.mylist![index].doctor}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${model.mylist![index].date}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],),

              );

            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 15,mainAxisExtent: 200)
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: (){
            model.navaddpres();
          },child: Icon(Icons.add,color: Colors.white,),),
        );
      },
      viewModelBuilder: () => MyPrescriptionsModel(),
    );
  }
}
