import 'package:app_usage/app_usage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<AppUsageInfo> _infos=<AppUsageInfo>[].obs;
  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList =
      await AppUsage().getAppUsage(startDate, endDate);
      _infos.value = infoList;
      _infos.refresh();

      for (var info in infoList) {
        print(info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
  final count = 0.obs;
  @override
  void onInit() {
    getUsageStats();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
