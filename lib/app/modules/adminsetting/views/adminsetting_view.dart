import 'package:citiguide/widgets/Appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/adminsetting_controller.dart';

class AdminsettingView extends GetView<AdminsettingController> {
  const AdminsettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Settings"),
      body: Center(
        child: Column(
          children: [
            LinkCard("City", "Add and View Cities", Icons.location_city,
                '/admincity'),
            LinkCard(
                "Place", "Add and View Places", Icons.place, '/adminplaces'),
          ],
        ),
      ),
    );
  }

  Widget LinkCard(String title, String Desc, IconData icon, String url) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Desc,
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Limit to 2 lines
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () => Get.toNamed(url),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
