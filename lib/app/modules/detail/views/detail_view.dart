import 'package:cached_network_image/cached_network_image.dart';
import 'package:citiguide/widgets/Appbar.dart';
import 'package:citiguide/widgets/ButtonWithIcon.dart';
import 'package:citiguide/widgets/StarRating.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic data = Get.arguments;
    controller.title.value = data['title'];
    controller.city.value = data['city'];
    controller.fetchReviews(controller.city.value, controller.title.value);
    return Scaffold(
      appBar: appbar("${data['title']}"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: data['image'],
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                SizedBox(height: 15),
                Text(
                  "${data['title']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "${data['type']}",
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "${controller.reviewslist.length} Reviews",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Text(
                                  controller.avg_rating.value
                                      .toStringAsFixed(2)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Obx(
                                () => StarRating(
                                  rating: controller.avg_rating.value
                                      .roundToDouble(),
                                  onRatingChanged: (rating) => () {},
                                  color: Color(0xFFffba49),
                                ),
                              )
                            ],
                          )
                        ]),
                    ButtonWithIcon(
                      text: "Add Review",
                      onPressed: () {
                        Get.toNamed('/addreview', arguments: data);
                      },
                      width: 130,
                      height: 40,
                      buttontextsize: 12,
                      icon: "assets/EditSquare.svg",
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.reviewslist.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final review = controller.reviewslist[index];
                        return Items(review['rating'].toInt(), review['name'],
                            review['comment']);
                      },
                    ))
              ]),
        ),
      ),
    );
  }

  Widget Items(int rating, String name, String comment) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "https://www.iconpacks.net/icons/2/free-user-icon-3296-thumb.png",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(
                      rating.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "rating",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )),
                  ]),
                  StarRating(
                    rating: rating.toDouble(),
                    onRatingChanged: (rating) => () {},
                    color: Color(0xFFffba49),
                  )
                ])
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              comment,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF676767),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
