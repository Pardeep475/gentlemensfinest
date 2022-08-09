import 'package:gentleman_finest/app/auth/login/page/login_screen.dart';
import 'package:gentleman_finest/app/dashboard/page/dashboard_screen.dart';
import 'package:gentleman_finest/common/routes/route_strings.dart';
import 'package:get/get.dart';

import '../../app/auth/splash/page/splash_screen.dart';

class Routes {
  static List<GetPage>? generateRoute() {
    return [
      GetPage(
        name: RouteString.splashScreen,
        page: () => SplashScreen(),
      ),
      GetPage(
        name: RouteString.loginScreen,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: RouteString.dashBoardScreen,
        page: () => DashboardScreen(),
      ),
    ];
  }
}
