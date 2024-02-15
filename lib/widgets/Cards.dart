import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget Cards(String title, String description, String icontype ,  dynamic  data) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icontype == "hotel"
                ? Icons.hotel
                : icontype == "building"
                    ? Icons.business
                    : icontype == "restaurant"
                        ? Icons.local_dining
                        : icontype == "video"
                            ? Icons.video_file
                            : icontype == "pdf"
                                ? Icons.picture_as_pdf
                                : Icons.image,
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
                    description,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Limit to 2 lines
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
                Get.toNamed('/detail', arguments: data);
            },
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}
