import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AddreviewController extends GetxController {
  //TODO: Implement AddreviewController

  final RxDouble sliderRating = 0.0.obs;

  late TextEditingController name = new TextEditingController();

  late TextEditingController comment = new TextEditingController();

  final  title = "".obs;
  final email = FirebaseAuth.instance.currentUser!.email.toString().obs;
  final city = "".obs;

  final AddreviewformKey = GlobalKey<FormState>();
  final count = 0.obs;
  @override
  void onInit() {
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

  void submitReview()  {
    //add review in firebase realtime database

    DatabaseReference ref = FirebaseDatabase.instance.ref("reviews");
 
     ref.push().set({
      "name": name.text,
      "comment": comment.text,
      "rating": sliderRating.value,
      "title": title.value,
      "city": city.value,
      "email": email.value
    });

    name.clear();
    comment.clear();
    Get.snackbar(
      "Success",
      "Review added successfully",
    );
    Get.toNamed('/home');
  }
}
