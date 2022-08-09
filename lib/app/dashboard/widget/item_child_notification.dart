import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_button_without_corner.dart';
import '../../../common/widget/app_text.dart';

class ItemChildNotification extends StatelessWidget {
  const ItemChildNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(AppImages.imgRejected,height: 70,),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.imgProfile,
                  height: 64.r,
                  width: 64.r,
                ),
                SizedBox(
                  width: 16.h,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        textAlign: TextAlign.start,
                        text: 'Albert Huston',
                        color: Colors.black,
                        fontFamily: AppStrings.outfitFont,
                        fontWeight: FontWeight.w700,
                        textSize: 15.sp,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      AppText(
                        textAlign: TextAlign.start,
                        text:
                            'I saw your ad on gentlemen\'s finest and Im getting in touch to ask about arranging a session with you.',
                        color: Colors.black,
                        fontFamily: AppStrings.outfitFont,
                        fontWeight: FontWeight.w400,
                        maxLines: 3,
                        lineHeight: 1.3,
                        textSize: 12.sp,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 1.h, // space between underline and text
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xff5B94EA), // Text colour here
                              width: 1.0, // Underline width
                            ),
                          ),
                        ),
                        child: Text(
                          AppStrings.viewMoreDetails.tr,
                          style: TextStyle(
                            color: const Color(0xff5B94EA), // Text colour here
                            fontFamily: AppStrings.outfitFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffEDEDED), width: 1),
                        ),
                        child: Row(
                          children: [
                             Expanded(
                              child:  AppButtonWithoutCorner(
                                title: AppStrings.accept.tr,
                                onPressed: (){},
                              ),
                            ),
                            Divider(
                              color: const Color(0xffEDEDED),
                              thickness: 1,
                              height: 40.h,
                            ),
                             Expanded(
                              child:  AppButtonWithoutCorner(
                                title: AppStrings.reject.tr,
                                buttonBackgroundColor: Colors.white,
                                txtColor: Colors.black,
                                onPressed: (){},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.h,
                ),
                AppText(
                  textAlign: TextAlign.end,
                  text: '1 min ago',
                  color: const Color(0xff6C6C6C),
                  fontFamily: AppStrings.outfitFont,
                  fontWeight: FontWeight.w500,
                  textSize: 12.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h,),
            const Divider(color: Color(0xff7E7B7B),height: 1,),
          ],
        ),
      ],
    );
  }
}
