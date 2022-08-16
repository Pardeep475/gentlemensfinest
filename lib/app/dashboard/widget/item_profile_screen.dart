import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../network/modal/booking_details_api_response.dart';
import '../controller/dashboard_controller.dart';
import 'item_child_profile.dart';
import 'item_header_dialog.dart';

class ItemProfileScreen extends StatelessWidget {
  const ItemProfileScreen(
      {required this.controller, required this.bookingInfo, Key? key})
      : super(key: key);

  final DashboardController controller;
  final BookingDetails bookingInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.red, width: 0.5.r),
            ),
            child: Column(
              children: [
                ItemHeaderDialog(
                  title: AppStrings.detailsFor.tr + bookingInfo.customerName,
                  onBackPressed: () {
                    controller.updateItemProfileOpenPressed(false);
                  },
                ),
                ItemChildProfile(
                  title: '${AppStrings.phone.tr}\n${bookingInfo.phoneNumber}',
                  icon: AppImages.imgPhone,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: '${AppStrings.email.tr}\n${bookingInfo.customerEmail}',
                  icon: AppImages.imgEmail,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.desiredModel.tr,
                  icon: AppImages.imgModal,
                  content:
                      bookingInfo.desiredModel,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.dateAndTime.tr,
                  icon: AppImages.imgClock,
                  content: '${bookingInfo.desiredDate}, ${bookingInfo.desiredTime} ${AppStrings.duration.tr} ${bookingInfo.duration}',
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.location.tr,
                  icon: AppImages.imgLocation,
                  content: bookingInfo.location,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  isDivider: false,
                  title: AppStrings.detailedInfo.tr,
                  icon: AppImages.imgInfo,
                  content:
                      bookingInfo.aboutCustomer,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
