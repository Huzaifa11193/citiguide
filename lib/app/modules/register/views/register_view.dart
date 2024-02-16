import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show an alert dialog when the user presses the back button
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App?'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Exit'),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
          centerTitle: true,
        ),
         body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(imageUrl: "https://cdn2.iconfinder.com/data/icons/call-to-action-1/512/7.Log_in-512.png"
                   , height: 200, width: 200,
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: controller.RegisterformKey[1],
                    child:
                    Column(
                      children: [
                        TextFormField(
                           validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailAddress ,
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
                          if( controller.RegisterformKey[1].currentState!.validate()) {
                            
                            controller.createUserWithEmailAndPassword();
                          }
          
                        }, child: Text('Register'))
                      ],
                    ) 
                  ),
                )
                ,SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Already have an account?"),
                  TextButton(onPressed: () {
                    Get.toNamed('/login');
                  }, child: Text("Login"))
                ],)
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}
