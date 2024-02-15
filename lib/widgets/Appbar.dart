
import 'package:citiguide/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


AppBar appbar(String title){

  HomeController homeController = Get.put(HomeController());
  
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
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