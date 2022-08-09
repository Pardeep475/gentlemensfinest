import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gentleman_finest/common/app_strings.dart';
import 'package:get/get.dart';

import '../../../common/app_images.dart';
import '../../../common/widget/app_text.dart';

class ItemLogout extends StatelessWidget {
  const ItemLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              textAlign: TextAlign.center,
              text: AppStrings.logOut.tr,
              color: Colors.black,
              fontFamily: AppStrings.outfitFont,
              fontWeight: FontWeight.w700,
              textSize: 18.sp,
            ),
            SizedBox(
              width: 13.w,
            ),
            SvgPicture.asset(AppImages.iconLogout),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
