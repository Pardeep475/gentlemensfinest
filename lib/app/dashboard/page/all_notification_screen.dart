import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/network/modal/notification_api_response.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../controller/dashboard_controller.dart';
import '../widget/item_child_notification.dart';
import '../widget/item_today_notification.dart';
import '../../../common/utils.dart';

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
          Obx(() {
            return ItemTodayNotification(
              notification: controller.todayNotificationCount.value,
            );
          }),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: GroupedListView<dynamic, String>(
                physics: const BouncingScrollPhysics(
                    parent: ClampingScrollPhysics()),
                shrinkWrap: true,
                elements: dataList,
                padding: EdgeInsets.only(top: 20.h,bottom: 20.h),
                groupBy: (dynamic element) => element.groupBy,
                // groupComparator: (value1, value2) => value2.compareTo(value1),
                groupSeparatorBuilder: (dynamic element) => Container(
                  margin: EdgeInsets.only(top: 20.h),
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    textAlign: TextAlign.center,
                    // text: fetchDataAndTime(element),
                    text: element,
                    color: Colors.black,
                    fontFamily: AppStrings.outfitFont,
                    fontWeight: FontWeight.w500,
                    textSize: 22.sp,
                  ),
                ),
                indexedItemBuilder: (context, dynamic element, int index) =>
                    ItemChildNotification(
                  item: element,
                  index: index,
                  length: dataList.length,
                  onPressed: (value) =>
                      onClickEvent(value: value, id: element.bookingId),
                ),
                // order: GroupedListOrder.DESC,
                itemComparator: (e1, e2) => DateFormat("dd-MMM-yyyy HH:mm:ss")
                    .parse(e2.bookingDate)
                    .compareTo(DateFormat("dd-MMM-yyyy HH:mm:ss")
                        .parse(e1.bookingDate)), // optional
                // elementIdentifier: (element) => element.name // optional - see below for usage
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     padding: EdgeInsets.only(bottom: 20.h),
          //     itemBuilder: (BuildContext context, int index) {
          //       return ItemChildNotification(
          //         item: dataList[index],
          //         index: index,
          //         length: dataList.length,
          //         onPressed: (value) =>
          //             onClickEvent(value: value, id: dataList[index].bookingId),
          //       );
          //     },
          //     itemCount: dataList.length,
          //   ),
          // )
        ],
      ),
    );
  }

  onClickEvent({required int value, required int id}) async {
    // 0 = accept list, 1 = reject list, 2 = view details
    switch (value) {
      case 0:
        {
          // accept list
          controller.acceptAndRejectApi(bookingId: id, acceptReject: 1);
        }
        break;
      case 1:
        {
          // reject list
          controller.acceptAndRejectApi(bookingId: id, acceptReject: '0');
        }
        break;
      case 2:
        {
          // view details
          var value = await controller.fetchBookingDetails(bookingId: id);
          if (value != null) {
            controller.updateItemProfileOpenPressed(true);
          } else {
            Utils.errorSnackBar(
                AppStrings.error.tr, AppStrings.somethingWentWrong.tr);
          }
        }
        break;
      default:
        {}
    }
  }

  String fetchDataAndTime(dynamic element) {
    var dateTime = DateFormat("MMMM d yyyy").parse(element);
    if(Utils.isSameDateFromDateTime(dateTime)){
      return AppStrings.today.tr;
    } else {
      return dateTime.toString();
    }

  }

  String groupedBy(dynamic element) {
    var dateTime = DateFormat("dd-MMM-yyyy HH:mm:ss").parse(element.bookingDate);
    final DateFormat formatter = DateFormat('MMMM d yyyy');
    return formatter.format(dateTime);
  }

}
