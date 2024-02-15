import 'package:citiguide/widgets/Appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addreview_controller.dart';

class AddreviewView extends GetView<AddreviewController> {
  const AddreviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final dynamic data = Get.arguments;
    controller.title.value = data['title'];
    controller.city.value = data['city'];

    return Scaffold(
      appBar: appbar("Add Review"),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Form(
            key: controller.AddreviewformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
            Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                      
               Padding(
                 padding: const EdgeInsets.only(top:8.0),
                 child: TextFormField(
                  controller: controller.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                    filled: true, // Enable filled background
                    fillColor: Color(0xFFF2F3F2),
                    
                    border: OutlineInputBorder(),
                    hintText: 'Type your name',
                  )
                           ),
               ),
                  
              SizedBox(
                height: 20,
              ),
          
             Text("How was your experience ?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                 
          
             Padding(
              padding: const EdgeInsets.only(top:8.0),
               child: TextFormField(
                controller: controller.comment,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter comment';
                  }
                  return null;
                },
                maxLines: 8,
                  decoration: InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                    filled: true, // Enable filled background
                    fillColor: Color(0xFFF2F3F2),
                    
                    border: OutlineInputBorder(),
                    hintText: 'Describe your experience',
                  )
                ),
             ),
                  
          
              SizedBox(
                height: 20,
              ),
          
             Text("Star",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                 
                 
                 Obx(
                   () => Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                    Text('0.0'),
                    Expanded(
                      child: Slider(
                        value: controller.sliderRating.value,
                        min: 0.0,
                        max: 5.0,
                        onChanged: (value) {
                          controller.sliderRating.value = value;
                         
                        },
                        thumbColor: Color(0xFF06BDEC),
                        activeColor: Color(0xFFF5F6FA),
                        inactiveColor: Color(0xFFF5F6FA),
                      ),
                    ),
                    Text('5.0'),
                                 ],
                               ),
                             
                             ],
                    ),
                 ),
          
            SizedBox(
              height: 20,
            ),

            ElevatedButton(onPressed: () {
              if( controller.AddreviewformKey.currentState!.validate()) {
                controller.submitReview();
              }
            }, child: Text('Submit'))
          
            ]),
          ),
        ),
      )
    );
  }
}
