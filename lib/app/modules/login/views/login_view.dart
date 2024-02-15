import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(imageUrl: "https://cdn-icons-png.freepik.com/512/295/295128.png"
                 , height: 200, width: 200,
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.LoginformKey,
                  child:
                  Column(
                    children: [
                      TextFormField(
                       
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailAddress ,
                         validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controller.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () {
                        if( controller.LoginformKey.currentState!.validate()) {
                          
                          controller.signInWithEmailAndPassword();
                        }
                      }, child: Text('Login'))
                    ],
                  ) 
                ),
              )
              ,SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have an account?"),
                TextButton(onPressed: () {
                  Get.toNamed('/register');
                }, child: Text("Register"))
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
