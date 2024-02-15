import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailController extends GetxController {
  //TODO: Implement DetailController
  late RxList<dynamic> reviewslist = [].obs;
  final city = "".obs;
  final title = "".obs;
  final count = 0.obs;

  final avg_rating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews(city.value, title.value);
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

 

  Future<void> fetchReviews(String city, String title) async {
    // Get a reference to the database
    DatabaseReference ref = FirebaseDatabase.instance.ref("reviews");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    reviewslist.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      if (data['city'].toString() == city &&
          data['title'].toString() == title) {
        reviewslist.add(data);
      }
    });

    //apply average rating
    double sum = 0;
    for (int i = 0; i < reviewslist.length; i++) {
      sum += reviewslist[i]['rating'];
    }
    avg_rating.value = sum / reviewslist.length;
  }
}
