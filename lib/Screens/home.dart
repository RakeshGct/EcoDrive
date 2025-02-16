import 'package:eco_drive/Provider/vehicle_provider.dart';
import 'package:eco_drive/Screens/add_vehicle.dart';
import 'package:eco_drive/Screens/edit_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  Color getVehicleColor(int mileage, int year) {
    int currentYear = DateTime.now().year;
    int age = currentYear - year;
    if (mileage >= 15 && age <= 5) {
      return Colors.green;
    } else if (mileage >= 15 && age > 5) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  Color getTextColor(Color cardColor) {
    if (cardColor == Colors.red) return Colors.white;
    if (cardColor == Colors.green) return Colors.white;
    if (cardColor == Colors.amber) return Colors.black;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Vehicles List'),
        centerTitle: true,
      ),
      body: Consumer<VehicleProvider>(
        builder: (context, vehicleProvider, child) {
          if (vehicleProvider.vehicles.isEmpty) {
            return Center(child: Text('No vehicles found'));
          }
          return ListView.builder(
            itemCount: vehicleProvider.vehicles.length,
            itemBuilder: (context, index) {
              var data = vehicleProvider.vehicles[index];
              Color vehicleColor = getVehicleColor(data['mileage'], data['year_of_manufacture']);
              Color textColor = getTextColor(vehicleColor);
              return Card(
                color: vehicleColor,
                child: ListTile(
                  title: Text("MODEL : ${data['name']}", style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text("BRAND : ${data['brand']} | ${data['mileage']} Km/Ltr", style: TextStyle(color: textColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: textColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditVehicle(vehicle: data),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: textColor),
                        onPressed: () {
                          vehicleProvider.deleteVehicle(data['id']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        shape: Border.all(color: Colors.lightGreenAccent, style: BorderStyle.solid,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicle()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
