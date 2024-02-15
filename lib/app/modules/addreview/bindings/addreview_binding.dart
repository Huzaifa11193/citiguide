import 'package:get/get.dart';

import '../controllers/addreview_controller.dart';

class AddreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddreviewController>(
      () => AddreviewController(),
    );
  }
}
