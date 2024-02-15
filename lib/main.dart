import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser; 
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: user == null ? AppPages.LOGIN : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
