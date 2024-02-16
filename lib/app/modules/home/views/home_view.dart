import 'package:cached_network_image/cached_network_image.dart';
import 'package:citiguide/widgets/Appbar.dart';
import 'package:citiguide/widgets/Cards.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Key dropdownKey = UniqueKey();

    return Obx(
      () => WillPopScope(
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
          appBar: appbar("Home"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomSearchableDropDown(
                  dropdownHintText: 'Search For Name Here... ',
                  showLabelInMenu: true,
                  primaryColor: Colors.blue,
                  menuMode: true,
                  labelStyle:
                      TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  items: controller.listToSearch,
                  label: 'Select Name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.search, color: Colors.blue),
                  ),
                  dropDownMenuItems: controller.listToSearch.map((item) {
                    return item['name']["name"].toString();
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selected.value =
                          value['name']["name"].toString();
                      controller.fetchDataFromData(controller.selected.value);
                    } else {
                      controller.selected.value = "";
                    }
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listToSearchResult.length == 0
                      ? 1
                      : controller.listToSearchResult.length,
                  itemBuilder: (context, index) {
                    if (controller.listToSearchResult.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://icons.veryicon.com/png/o/internet--web/internet-industry-business-icon/map-location-1.png",
                            height: 200,
                            width: 200),
                      );
                    }
                    return Cards(
                      controller.listToSearchResult[index]['title'].toString(),
                      controller.listToSearchResult[index]['description']
                          .toString(),
                      controller.listToSearchResult[index]['type'].toString(),
                      controller.listToSearchResult[index],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
