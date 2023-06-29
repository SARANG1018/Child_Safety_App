import 'package:get/get.dart';

import '../controllers/qr_code_controller.dart';

class QrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
  }
}
