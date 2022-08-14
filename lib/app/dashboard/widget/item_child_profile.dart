import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/app_color.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';

class ItemChildProfile extends StatelessWidget {
  final String title;
  final String content;
  final String icon;
  final VoidCallback onPressed;
  final bool isDivider;

  const ItemChildProfile(
      {required this.title,
      this.content = '',
      this.isDivider = true,
      required this.icon,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: content.isEmpty ? 10.h : 14.h,
                    ),
                    AppText(
                      textAlign: TextAlign.start,
                      text: title,
                      lineHeight: 1.4,
                      color: Colors.black54,
                      maxLines: 2,
                      fontFamily: AppStrings.outfitFont,
                      fontWeight: FontWeight.w700,
                      textSize: 18.sp,
                    ),
                    content.isEmpty
                        ? const SizedBox()
                        : AppText(
                            textAlign: TextAlign.start,
                            text: content,
                            color: Colors.black54,
                            maxLines: 2,
                            fontFamily: AppStrings.outfitFont,
                            fontWeight: FontWeight.w700,
                            textSize: 12.sp,
                          ),
                    SizedBox(
                      height: content.isEmpty ? 10.h : 14.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Image.asset(
                icon,
                height: 28.r,
                width: 28.h,
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
          isDivider
              ? Divider(
                  height: 1.h,
                  color: AppColor.red,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
