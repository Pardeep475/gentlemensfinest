import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../widget/item_child_notification.dart';
import '../widget/item_today_notification.dart';

class AllNotificationScreen extends StatefulWidget {
  const AllNotificationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllNotificationScreenState();
}

class _AllNotificationScreenState extends State<AllNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 12.h,),
          AppText(
            textAlign: TextAlign.center,
            text: AppStrings.notification.tr,
            color: Colors.black,
            fontFamily: AppStrings.outfitFont,
            fontWeight: FontWeight.w700,
            textSize: 36.sp,
          ),
          SizedBox(height: 6.h,),
          const ItemTodayNotification(notification: 3,),
          SizedBox(height: 20.h,),
          const ItemChildNotification(),
        ],
      ),
    );
  }
}
