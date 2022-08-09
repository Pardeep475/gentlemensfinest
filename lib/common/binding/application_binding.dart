import 'package:gentleman_finest/app/auth/login/controller/login_controller.dart';
import 'package:gentleman_finest/app/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../app/auth/splash/controller/splash_controller.dart';
import 'binding_consts.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),
        tag: BindingConst.splashScreenBinding);
    Get.lazyPut(() => LoginController(), tag: BindingConst.loginScreenBinding);
    Get.lazyPut(() => DashboardController(),
        tag: BindingConst.dashboardScreenBinding);
  }
}
