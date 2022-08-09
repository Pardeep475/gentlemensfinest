import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_color.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemChildLogin extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ItemChildLogin({required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 35.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w),
              child: AppText(
                textAlign: TextAlign.center,
                text: title,
                color: Colors.black54,
                fontFamily: AppStrings.outfitFont,
                fontWeight: FontWeight.w700,
                textSize: 18.sp,
              ),
            ),
            SizedBox(height: 10.h,),
            Divider(
              height: 1.h,
              color: AppColor.red,
            ),
          ],
        ),
      ),
    );
  }
}
