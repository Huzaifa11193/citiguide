import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AdmincityController extends GetxController {
  //TODO: Implement AdmincityController

  late TextEditingController city = new TextEditingController();
  final cityformKey = GlobalKey<FormState>();
  late RxList<dynamic> citiesRecords = [].obs;

  
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCities();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> fetchCities() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cities");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    citiesRecords.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      citiesRecords.add(data);
    });
   
  }

  Future<void> deleteCity(String city) async {
    print(city);
    DatabaseReference ref = FirebaseDatabase.instance.ref("cities");

    // Delete the city
    await ref
        .orderByChild("name")
        .equalTo(city)
        .once()
        .then((value) => value.snapshot.children
            .first
            .ref
            .remove()
            .then((value) => fetchCities()));
            Get.snackbar("Success", "City Deleted");
  }

  Future<void> addCity() async {
    // Add City and it should be unqiue

    final DatabaseReference _database = FirebaseDatabase.instance.reference();
    //check if city already exists
    if (await _database
        .child("cities")
        .orderByChild("name")
        .equalTo(city.text)
        .once()
        .then((value) => value.snapshot.exists)) {
      Get.snackbar("Error", "City Already Exists");
      return;
    }
    _database.child("cities").push().set({
      "name": city.text,
    });
    city.clear();
    fetchCities();
    Get.snackbar("Success", "City Added");
  }
}
