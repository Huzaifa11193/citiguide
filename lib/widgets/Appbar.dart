import 'package:citiguide/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

AppBar appbar(String title) {
  HomeController homeController = Get.put(HomeController());

 final email = FirebaseAuth.instance.currentUser!.email.toString().obs;
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      email == "admin@citiguide.com" ?
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/adminsetting');
          },
          child: const Icon(Icons.admin_panel_settings),
        ),
      ) : Container(),
      GestureDetector(
        onTap: () {
          Get.toNamed('/changepassword');
        },
        child: const Icon(Icons.password),
      ),
      IconButton(
        onPressed: () {
          homeController.signout();
        },
        icon: const Icon(Icons.logout),
        tooltip: 'Logout',
      ),
    ],
  );
}
