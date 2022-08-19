import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_color.dart';
import 'package:gentleman_finest/common/app_strings.dart';
import 'package:get/get.dart';

class ItemTodayNotification extends StatelessWidget {
  final int notification;
  final String language;

  const ItemTodayNotification(
      {this.notification = 0, required this.language, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppStrings.youHave.tr,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
          fontFamily: AppStrings.outfitFont,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' $notification ${AppStrings.notifications.tr} ',
            style: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              fontFamily: AppStrings.outfitFont,
            ),
          ),
          TextSpan(
            text: language == AppStrings.english
                ? AppStrings.today.tr.toLowerCase()
                : '',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              fontFamily: AppStrings.outfitFont,
            ),
          ),
        ],
      ),
    );
  }
}
