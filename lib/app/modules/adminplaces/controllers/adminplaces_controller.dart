import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminplacesController extends GetxController {
  //TODO: Implement AdminplacesController
  final city = "".obs;
  late TextEditingController description = new TextEditingController();
  late TextEditingController gmap = new TextEditingController();
  late TextEditingController image = new TextEditingController();
  late TextEditingController location = new TextEditingController();
  late TextEditingController title = new TextEditingController();
  final type = "".obs;
  final placeformKey = GlobalKey<FormState>();
  late RxList<dynamic> citiesRecords = [].obs;
  late RxList<dynamic> placesRecords = [].obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    fetchplaces();
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

  Future<void> addPlace() async {
    // Add City and it should be unqiue
    final DatabaseReference _database = FirebaseDatabase.instance.reference();
    _database.child("data").push().set({
      "city": city.value,
      "description": description.text,
      "gmap": gmap.text,
      "image": image.text,
      "location": location.text,
      "title": title.text,
      "type": type.value
    });
    description.clear();
    gmap.clear();
    image.clear();
    location.clear();
    title.clear();

    fetchplaces();
    Get.snackbar("Success", "Place Added");
  }

  Future<void> fetchplaces() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    placesRecords.clear();

    // Iterate through children and add values to the list also add key with it
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      //also attach key with it
      data['key'] = element.key;

      placesRecords.add(data);
    });
  }

  Future<void> deletePlace(String id) async {
    print(id);
    DatabaseReference ref = FirebaseDatabase.instance.ref("data/$id");
    ref.remove();
    fetchplaces();
    Get.snackbar("Success", "Place Deleted");
  }
}
