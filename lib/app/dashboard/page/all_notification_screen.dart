import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/network/modal/notification_api_response.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/booking_details_api_response.dart';
import '../controller/dashboard_controller.dart';
import '../widget/item_child_notification.dart';
import '../widget/item_profile_screen.dart';
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
            text: getNotificationTypeTitle(),
            color: Colors.black,
            fontFamily: AppStrings.outfitFont,
            fontWeight: FontWeight.w700,
            textSize: 36.sp,
          ),
          SizedBox(
            height: notificationScreenType == 0 ? 6.h : 0,
          ),
          Visibility(
            visible: notificationScreenType == 0,
            child: Obx(() {
              return ItemTodayNotification(
                notification: controller.todayNotificationCount.value,
                language: controller.language.value,
              );
            }),
          ),
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
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                groupBy: (dynamic element) => element.groupBy,
                // groupComparator: (value1, value2) => value2.compareTo(value1),
                groupSeparatorBuilder: (dynamic element) {
                  String title;
                  if(element == AppStrings.today){
                    title =  AppStrings.today.tr;
                  } else if(element == AppStrings.thisWeek){
                    title =  AppStrings.thisWeek.tr;
                  } else {
                    title =  AppStrings.older.tr;
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 20.h),
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      textAlign: TextAlign.center,
                      // text: fetchDataAndTime(element),
                      text: title,
                      color: Colors.black,
                      fontFamily: AppStrings.outfitFont,
                      fontWeight: FontWeight.w500,
                      textSize: 22.sp,
                    ),
                  );
                },
                indexedItemBuilder: (context, dynamic element, int index) =>
                    ItemChildNotification(
                  item: element,
                  lastIndexId: dataList[dataList.length - 1].bookingId,
                  onPressed: (value) => onClickEvent(
                    value: value,
                    id: element.bookingId,
                  ),
                  language: controller.language.value,
                ),
                order: GroupedListOrder.ASC,
                sort: false,
                itemComparator: (e1, e2) => DateFormat("dd-MMM-yyyy HH:mm:ss")
                    .parse(e2.bookingDate)
                    .compareTo(DateFormat("dd-MMM-yyyy HH:mm:ss")
                        .parse(e1.bookingDate)), // optional
                // elementIdentifier: (element) => element.name // optional - see below for usage
              ),
            ),
          ),
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
          controller.acceptAndRejectApi(bookingId: id, acceptReject: 'yes');
        }
        break;
      case 1:
        {
          // reject list
          controller.acceptAndRejectApi(bookingId: id, acceptReject: 'no');
        }
        break;
      case 2:
        {
          // view details
          var value = await controller.fetchBookingDetails(bookingId: id);
          if (value != null) {
            openProfileDialog(bookingInfo: value);
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
    if (Utils.isSameDateFromDateTime(dateTime)) {
      return AppStrings.today.tr;
    } else {
      return dateTime.toString();
    }
  }

  String getNotificationTypeTitle() {
    switch (notificationScreenType) {
      case 0:
        {
          return AppStrings.notification.tr;
        }
      case 1:
        {
          return AppStrings.requestsAccepted.tr;
        }
      case 2:
        {
          return AppStrings.requestsRejected.tr;
        }
      default:
        {
          return AppStrings.notification.tr;
        }
    }
  }

  openProfileDialog({required BookingDetails bookingInfo}) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: ItemProfileScreen(
                    controller: controller,
                    bookingInfo: bookingInfo,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
