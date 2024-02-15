import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/changepassword_controller.dart';

class ChangepasswordView extends GetView<ChangepasswordController> {
  const ChangepasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(imageUrl: "https://cdn-icons-png.flaticon.com/512/6195/6195699.png"
                 , height: 200, width: 200,
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.changePasswordformKey,
                  child:
                  Column(
                    children: [

                  TextField(
                    enabled: false,
                    readOnly : true,
                       
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "${controller.email}",
                        ),

                      ),
                   
                      SizedBox(height: 10),

                        TextFormField(
                        controller: controller.oldpassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Old Password',
                        ),
                      ),
                    
                 
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controller.newpassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(onPressed: () {
                        if( controller.changePasswordformKey.currentState!.validate()) {
                          
                          controller.changePassword();
                        }
                      }, child: Text('Change Password'))
                    ],
                  ) 
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }
}
