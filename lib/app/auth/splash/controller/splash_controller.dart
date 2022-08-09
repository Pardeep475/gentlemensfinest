import 'package:gentleman_finest/common/routes/route_strings.dart';
import 'package:get/get.dart';

import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    openFurtherScreen();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }

  openFurtherScreen() async {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      bool isLogin = await SessionManager.isLogin();

      Get.offAndToNamed(
          isLogin ? RouteString.dashBoardScreen : RouteString.loginScreen);
    });
  }
}
