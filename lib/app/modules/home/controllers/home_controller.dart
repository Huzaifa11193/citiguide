import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  late final selected = "".obs;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  late RxList<dynamic> listToSearch = [].obs;

  late RxList<dynamic> listToSearchResult = [].obs;

  @override
  void onInit() {
    fetchDataFromDatabase();
    super.onInit();
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

  void signout() {
    FirebaseAuth.instance.signOut();
     Get.offNamed('/login');
  }

  Future<void> fetchDataFromDatabase() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cities");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    listToSearch.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<String, dynamic> cityData = {
        "name": element.value, // Assuming the name is stored as the key
        // Add other data if necessary
      };
      listToSearch.add(cityData);
    });
  }

  Future<void> fetchDataFromData(String city) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    listToSearchResult.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
     
      if (data['city'].toString() == city) {
        listToSearchResult.add(data);
      }
     
    });
  }
}
