import 'package:eco_drive/Provider/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditVehicle extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  final TextEditingController nameController;
  final TextEditingController brandController;
  final TextEditingController mileageController;
  final TextEditingController yearController;

  EditVehicle({required this.vehicle})
      : nameController = TextEditingController(text: vehicle['name']),
        brandController = TextEditingController(text: vehicle['brand']),
        mileageController = TextEditingController(text: vehicle['mileage'].toString()),
        yearController = TextEditingController(text: vehicle['year_of_manufacture'].toString());

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Details'),
          centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: brandController, decoration: InputDecoration(labelText: 'Brand')),
            TextField(controller: mileageController, decoration: InputDecoration(labelText: 'Mileage'), keyboardType: TextInputType.number),
            TextField(controller: yearController, decoration: InputDecoration(labelText: 'Year of Manufacture'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                vehicleProvider.updateVehicle(vehicle['id'], nameController.text, brandController.text, int.parse(mileageController.text), int.parse(yearController.text));
                Navigator.pop(context);
              },
              child: Text('Update Vehicle Details'),
            ),
          ],
        ),
      ),
    );
  }
}
