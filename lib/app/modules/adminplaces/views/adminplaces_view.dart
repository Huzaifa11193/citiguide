import 'package:cached_network_image/cached_network_image.dart';
import 'package:citiguide/widgets/Appbar.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/adminplaces_controller.dart';

class AdminplacesView extends GetView<AdminplacesController> {
  const AdminplacesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add your cities here

    return Scaffold(
      appBar: appbar("Admin Places"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Form(
                key: controller.placeformKey,
                child: Column(children: [
                  Obx(
                    () => CustomSearchableDropDown(
                      dropdownHintText: 'Search For Name Here... ',
                      showLabelInMenu: true,
                      primaryColor: Colors.blue,
                      menuMode: true,
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      items: controller.citiesRecords,
                      label: 'Select City',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(Icons.search, color: Colors.blue),
                      ),
                      dropDownMenuItems: controller.citiesRecords.map((item) {
                        return item['name'].toString();
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.city.value = value['name'].toString();
                        } else {
                          controller.city.value = "";
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          maxLines: 3,
                          controller: controller.description,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: controller.title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: controller.location,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter location';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Location',
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: controller.gmap,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Google Map Link';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Google Map Link',
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        items: [
                          DropdownMenuItem(
                            child: Text('restaurant'),
                            value: 'restaurant',
                          ),
                          DropdownMenuItem(
                            child: Text('hotel'),
                            value: 'hotel',
                          ),
                        ],
                        onChanged: (value) {
                          controller.type.value = value.toString();
                        },
                        decoration: InputDecoration(
                          labelText: 'Type',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: controller.image,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter image url';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Image Url',
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.placeformKey.currentState!.validate() &&
                            controller.city.value != "" &&
                            controller.type.value != "") {
                          controller.addPlace();
                        }
                      },
                      child: Text('Add Place')),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.placesRecords.length == 0
                  ? Text("No Data")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.placesRecords.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = controller.placesRecords[index];

                        return ExpansionTile(
                          title: Text(controller.placesRecords[index]['title']),
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text("Delete Place"),
                                      content: Text(
                                          "Are you sure you want to delete this place?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              controller
                                                  .deletePlace(data['key']);
                                              Get.toNamed('/adminsetting');
                                            },
                                            child: Text("Delete")),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            CachedNetworkImage(
                              imageUrl: data['image'],
                              fit: BoxFit.cover,
                              height: 300,
                              width: double.infinity,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "${data['title']}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "${data['type']}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )),
                            SizedBox(height: 15),
                            Text(
                              "${data['description']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 15),
                            GestureDetector(
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${data['location']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton.icon(
                                onPressed: () {
                                  launchUrl(Uri.parse(data["gmap"]));
                                },
                                icon: Icon(Icons.location_on),
                                label: Text("Get Direction")),
                          ],
                        );
                      },
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
