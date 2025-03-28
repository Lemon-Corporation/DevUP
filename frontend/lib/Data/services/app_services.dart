import 'package:get/get.dart';

import 'data_service.dart';

class AppServices {
  static Future<void> init() async {
    await Get.putAsync<DataService>(() => DataService().init());
  }

  static Future<void> initMockData() async {}
}
