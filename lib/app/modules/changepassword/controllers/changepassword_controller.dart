import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangepasswordController extends GetxController {
  //TODO: Implement ChangepasswordController

  late TextEditingController newpassword = new TextEditingController();
  late  TextEditingController oldpassword = new TextEditingController();
  final changePasswordformKey = GlobalKey<FormState>();
  late String email = "Email Address".obs.toString();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
     FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        email = user!.email.toString();
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

  Future<void> changePassword() async {
      try{

        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        var cred = EmailAuthProvider.credential(email: user!.email.toString(), password: oldpassword.text);
        await user.reauthenticateWithCredential(cred);
        user.updatePassword(newpassword.text);
        Get.back();
        Get.snackbar("Success","Password Changed Succesfully");

      }catch(e){

        Get.snackbar("Error",e.toString());

      }
  }
}
