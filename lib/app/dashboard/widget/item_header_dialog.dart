import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemHeaderDialog extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const ItemHeaderDialog({required this.onBackPressed,required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.red,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              textAlign: TextAlign.left,
              text: title,
              color: AppColor.white,
              fontFamily: AppStrings.outfitFont,
              fontWeight: FontWeight.w700,
              textSize: 20.sp,
            ),
          ),
          SizedBox(width: 20.w,),
          GestureDetector(onTap: onBackPressed,child: SvgPicture.asset(AppImages.iconCross)),
        ],
      ),
    );
  }
}
