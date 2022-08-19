import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_strings.dart';
import 'package:gentleman_finest/common/local_storage/session_manager.dart';
import 'package:gentleman_finest/common/routes/route_strings.dart';
import 'package:get/get.dart';

import 'common/binding/application_binding.dart';
import 'common/routes/routes.dart';
import 'common/services/localization_service.dart';
import 'common/utils.dart';
import 'package:timeago/timeago.dart' as timeago;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale locale = await fetchLanguage();
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  runApp(MyApp(
    locale: locale,
  ));
}

Future<Locale> fetchLanguage() async {
  Utils.logger.e("locale:---   ${window.locale}  en_US  de_CH de_DE");
  String? language = await SessionManager.getLanguage();
  if (language == null) {
    return window.locale;
  } else {
    if (language == AppStrings.english) {
      return const Locale('en', 'US');
    } else {
      return const Locale('de', 'DE');
    }
  }
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({required this.locale, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utils.logger.e("locale:---   $locale ");
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
          locale: locale,
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
