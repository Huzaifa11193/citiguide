import 'package:get/get.dart';

import '../controllers/adminsetting_controller.dart';

class AdminsettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminsettingController>(
      () => AdminsettingController(),
    );
  }
}
