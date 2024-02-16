import 'package:get/get.dart';

import '../controllers/adminplaces_controller.dart';

class AdminplacesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminplacesController>(
      () => AdminplacesController(),
    );
  }
}
