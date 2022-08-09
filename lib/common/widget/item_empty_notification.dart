import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:get/get.dart';
import '../app_strings.dart';
import '../utils.dart';
import 'app_text.dart';

class ItemEmptyNotification extends StatelessWidget {
  const ItemEmptyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.imgEmptyNotification,
          height: 150.r,
          width: 150.r,
        ),
        SizedBox(
          height: 30.h,
        ),
        AppText(
          text: AppStrings.nothingHere.tr,
          color: Colors.black54,
          fontFamily: AppStrings.outfitFont,
          fontWeight: FontWeight.w700,
          textSize: 15.sp,
        ),
        SizedBox(
          height: 10.h,
        ),
        AppText(
          text: AppStrings.tapTheBellIconAboveAndCheckAgain.tr,
          color: Colors.black,
          fontFamily: AppStrings.outfitFont,
          fontWeight: FontWeight.w700,
          textSize: 15.sp,
        ),
        SizedBox(
          height: Utils.appBarHeightMargin,
        ),
      ],
    );
  }
}
