import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/network/modal/notification_api_response.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../controller/dashboard_controller.dart';
import '../widget/item_child_notification.dart';
import '../widget/item_today_notification.dart';

class AllNotificationScreen extends StatelessWidget {
  final DashboardController controller;
  final int notificationScreenType;
  final List<BookingInfo> dataList;

  const AllNotificationScreen(
      {this.notificationScreenType = 0,
      required this.dataList,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          AppText(
            textAlign: TextAlign.center,
            text: AppStrings.notification.tr,
            color: Colors.black,
            fontFamily: AppStrings.outfitFont,
            fontWeight: FontWeight.w700,
            textSize: 36.sp,
          ),
          SizedBox(
            height: 6.h,
          ),
          const ItemTodayNotification(
            notification: 3,
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20.h),
              itemBuilder: (BuildContext context, int index) {
                return ItemChildNotification(
                  item: dataList[index],
                  index: index,
                  length: dataList.length,
                  onPressed: (value) =>
                      onClickEvent(value: value, id: dataList[index].bookingId),
                );
              },
              itemCount: dataList.length,
            ),
          )
        ],
      ),
    );
  }

  onClickEvent({required int value, required int id}) {
    // 0 = accept list, 1 = reject list, 2 = view details
    switch (value) {
      case 0:
        {}
        break;
      case 1:
        {}
        break;
      case 2:
        {}
        break;
      default:
        {}
    }
  }
}
