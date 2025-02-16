import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class VehicleProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _vehicles = [];

  List<Map<String, dynamic>> get vehicles => _vehicles;

  VehicleProvider() {
    fetchVehicles();
  }

  void fetchVehicles() {
    _firestore.collection('vehicles').snapshots().listen((snapshot) {
      _vehicles = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
      notifyListeners();
    });
  }

  void addVehicle(String name, String brand, int mileage, int year) {
    _firestore.collection('vehicles').add({
      'name': name,
      'brand': brand,
      'mileage': mileage,
      'year_of_manufacture': year,
    });
  }

  void updateVehicle(String id, String name, String brand, int mileage, int year) {
    _firestore.collection('vehicles').doc(id).update({
      'name': name,
      'brand': brand,
      'mileage': mileage,
      'year_of_manufacture': year,
    });
  }

  void deleteVehicle(String id) {
    _firestore.collection('vehicles').doc(id).delete();
  }
}
