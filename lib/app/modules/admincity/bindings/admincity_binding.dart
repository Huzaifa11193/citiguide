import 'package:get/get.dart';

import '../controllers/admincity_controller.dart';

class AdmincityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdmincityController>(
      () => AdmincityController(),
    );
  }
}
