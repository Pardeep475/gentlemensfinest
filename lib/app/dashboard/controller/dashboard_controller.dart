import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/booking_details_api_response.dart';
import '../../../network/modal/notification_api_response.dart';

class DashboardController extends GetxController {
  // onHamburgerPressed
  var showLoader = false.obs;
  var onHamburgerPressed = false.obs;

  // 0 = all notification, 1 = accept notification, 2 = reject notification
  var notificationScreenType = 0.obs;

  RxList<BookingInfo> dataList = RxList();

  var itemProfileOpen = false.obs;
  BookingDetails? bookingInfo;

  var todayNotificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }

  reset() {
    showLoader.value = false;
    itemProfileOpen.value = false;
    onHamburgerPressed.value = false;
    notificationScreenType.value = 0;
    dataList = RxList();
  }

  void updateHamburgerPressed(bool value) {
    onHamburgerPressed.value = value;
  }

  void updateItemProfileOpenPressed(bool value) {
    itemProfileOpen.value = value;
  }

  void updateNotificationType(int value) {
    notificationScreenType.value = value;
  }

  Future fetchNotificationApi(
      {required dynamic acceptList, required dynamic rejectList}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider.getNotificationApi(
            acceptList: acceptList, rejectedList: rejectList);
        dataList.clear();
        if (response != null) {
          parseNotificationData(response as List<BookingInfo>);
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }
  
  parseNotificationData(List<BookingInfo> response){
    todayNotificationCount.value = response.where((element) => Utils.isSameDate(element.bookingDate)).length;
    dataList.addAll(response);
  }

  String getNotificationBackground() {
    switch (notificationScreenType.value) {
      case 0:
        {
          return AppImages.imgNotificationBackground;
        }
      case 1:
        {
          return AppImages.imgAcceptedBackground;
        }
      case 2:
        {
          return AppImages.imgRejectedBackground;
        }
      default:
        {
          return AppImages.imgNotificationBackground;
        }
    }
  }

  Future<BookingDetails?> fetchBookingDetails({required int bookingId}) async {
    bookingInfo = null;
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider
            .getBookingDetailsApi(bookingId: bookingId);
        if (response != null) {
          bookingInfo = (response as BookingDetails);
          return bookingInfo;
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

  Future acceptAndRejectApi(
      {required int bookingId, required dynamic acceptReject}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider.acceptAndRejectApi(
            bookingId: bookingId, acceptReject: acceptReject);
        if (response != null) {
          // further modification
          // 0 = all notification, 1 = accept notification, 2 = reject notification
          switch (notificationScreenType.value) {
            case 0:
              {
                fetchNotificationApi(acceptList: 1, rejectList: 1);
              }
              break;
            case 1:
              {
                fetchNotificationApi(acceptList: 'yes', rejectList: 'no');
              }
              break;
            case 2:
              {
                fetchNotificationApi(acceptList: 'no', rejectList: 'yes');
              }
              break;
            default:
              {
                fetchNotificationApi(acceptList: 1, rejectList: 1);
              }
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }
}
