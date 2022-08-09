import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_strings.dart';
import 'package:gentleman_finest/common/routes/route_strings.dart';
import 'package:get/get.dart';

import 'common/binding/application_binding.dart';
import 'common/routes/routes.dart';
import 'common/services/localization_service.dart';
import 'common/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utils.logger.e("locale:---   ${window.locale}");

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF9FA0A5),
                  ),
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              backgroundColor: Colors.white),
          locale: window.locale,
          builder: (context, child) => Scaffold(
            // Global GestureDetector that will dismiss the keyboard
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: child,
            ),
          ),
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
          initialRoute: RouteString.splashScreen,
          initialBinding: ApplicationBinding(),
          getPages: Routes.generateRoute(),
          fallbackLocale: LocalizationService.locale,
          translations: LocalizationService(),
          // home: child,
        );
      },
    );
  }
}
