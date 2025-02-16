import 'package:eco_drive/Provider/vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Vehicle"),
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
                vehicleProvider.addVehicle(
                  nameController.text,
                  brandController.text,
                  int.parse(mileageController.text),
                  int.parse(yearController.text),
                );
                Navigator.pop(context);
              },
              child: Text('Add Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
