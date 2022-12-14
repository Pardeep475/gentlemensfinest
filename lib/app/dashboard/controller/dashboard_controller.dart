import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/local_storage/session_manager.dart';
import '../../../common/utils.dart';
import '../../../network/api_provider.dart';
import '../../../network/modal/booking_details_api_response.dart';
import '../../../network/modal/notification_api_response.dart';

class DashboardController extends GetxController {
  // onHamburgerPressed
  var showLoader = false.obs;
  var showLoaderAcceptAndReject = false.obs;

  // 0 = all notification, 1 = accept notification, 2 = reject notification
  var notificationScreenType = 0.obs;

  RxList<BookingInfo> dataList = RxList();

  var todayNotificationCount = 0.obs;
  var language = AppStrings.english.obs;

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
    fetchLanguage();
  }

  fetchLanguage() async {
    language.value = await SessionManager.getLanguage() ?? AppStrings.english;
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
    notificationScreenType.value = 0;
    dataList = RxList();
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

  parseNotificationData(List<BookingInfo> response) {
    todayNotificationCount.value = response
        .where((element) => Utils.isSameDate(element.bookingDate))
        .length;
    response.sort((a, b) => DateFormat("dd-MMM-yyyy HH:mm:ss")
        .parse(b.bookingDate)
        .compareTo(DateFormat("dd-MMM-yyyy HH:mm:ss").parse(a.bookingDate)));
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
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderAcceptAndReject.value = true;
        var response = await ApiProvider.apiProvider
            .getBookingDetailsApi(bookingId: bookingId);
        if (response != null) {
          return (response as BookingDetails);
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoaderAcceptAndReject.value = false;
      }
    }
    return null;
  }

  Future acceptAndRejectApi(
      {required int bookingId, required dynamic acceptReject}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoaderAcceptAndReject.value = true;
        var response = await ApiProvider.apiProvider.acceptAndRejectApi(
            bookingId: bookingId, acceptReject: acceptReject);
        if (response != null) {
          // further modification
          // 0 = all notification, 1 = accept notification, 2 = reject notification

          int value = dataList.indexWhere((p0) => p0.bookingId == bookingId);
          BookingInfo info = dataList[value];
          info.acceptStatus = acceptReject == 'yes' ? 'yes' : 'no';
          dataList[value] = info;
          dataList.refresh();
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoaderAcceptAndReject.value = false;
      }
    }
    return null;
  }
}
