import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/widget/app_text.dart';
import 'package:gentleman_finest/network/modal/login_api_response.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'app_color.dart';
import 'app_strings.dart';
import 'local_storage/session_manager.dart';


class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  static double appBarHeightMargin = 77.h;

  static var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static errorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      margin: EdgeInsets.fromLTRB(
          10.w, 0, 10.w, 10.h),
      backgroundColor: AppColor.red.withOpacity(0.9),
      borderRadius: 5.sp,
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColor.red,
      titleText: AppText(
        text: title,
        color: Colors.white,
        fontFamily: AppStrings.outfitFont,
        fontWeight: FontWeight.w700,
        lineHeight: 1.6,
        textAlign: TextAlign.start,
        textSize: 18.sp,
      ),
      messageText: AppText(
        text: message,
        color: Colors.white,
        fontFamily: AppStrings.outfitFont,
        fontWeight: FontWeight.w400,
        lineHeight: 1.6,
        maxLines: 4,
        textAlign: TextAlign.start,
        textSize: 18.sp,
      ),
    );
  }

  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        Utils.errorSnackBar(AppStrings.error.tr,
            AppStrings.checkYourInternetConnectivity.tr);
        return false;
      }
    } on SocketException catch (_) {
      Utils.errorSnackBar(
          AppStrings.error.tr, AppStrings.checkYourInternetConnectivity.tr);
      return false;
    }
  }


  // date format like 1967-6-7
  static DateTime stringToDateOtherFormat({var selectedDate}) {
    try {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(selectedDate /*, isUtc: true*/);
      debugPrint("date time :-   $dateTime");
      return dateTime;
      // DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      // DateFormat targetFormat = new DateFormat("yyyy-MM-dd hh:mm:ss");
      // DateTime date = originalFormat.parse(selectedDate);
      // String formattedDate = targetFormat.format(date.toLocal());
      // return DateTime.parse(formattedDate);
    } catch (e) {
      return DateTime.now();
    }
  }

  // date format like 1967-6-7
  static DateTime stringToDateOtherFormatString({var selectedDate}) {
    try {
      // DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      // DateFormat targetFormat = new DateFormat("yyyy-MM-dd hh:mm:ss");
      // DateTime date = originalFormat.parse(selectedDate);
      // String formattedDate = targetFormat.format(date.toLocal());
      // return DateTime.parse(formattedDate);
      return DateTime.parse(selectedDate);

    } catch (e) {
      return DateTime.now();
    }
  }

  static Future<Escort?> getUserData() async {
    String? value = await SessionManager.getUserData();
    if (value != null) {
      return escortResponseFromJson(value);
    } else {
      return null;
    }
  }

}
