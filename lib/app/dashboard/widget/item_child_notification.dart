import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/app_strings.dart';
import '../../../common/widget/app_button_without_corner.dart';
import '../../../common/widget/app_text.dart';
import '../../../network/modal/notification_api_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemChildNotification extends StatelessWidget {
  final BookingInfo item;
  final int lastIndexId;
  final Function(int value) onPressed;
  final String language;

  const ItemChildNotification(
      {required this.item,
      required this.onPressed,
      required this.lastIndexId,
      required this.language,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        getImageBasedOnStatus().isEmpty
            ? const SizedBox()
            : Image.asset(
                getImageBasedOnStatus(),
                height: 70,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
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
                        text: item.customerName,
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
                        text: item.aboutCustomer,
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
                      GestureDetector(
                        onTap: () => onPressed(2),
                        child: Container(
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
                              color: const Color(0xff5B94EA),
                              // Text colour here
                              fontFamily: AppStrings.outfitFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      item.acceptStatus == 'new'
                          ? Container(
                              margin: EdgeInsets.only(top: 16.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xffEDEDED), width: 1),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppButtonWithoutCorner(
                                      title: AppStrings.accept.tr,
                                      onPressed: () => onPressed(0),
                                    ),
                                  ),
                                  Divider(
                                    color: const Color(0xffEDEDED),
                                    thickness: 1,
                                    height: 40.h,
                                  ),
                                  Expanded(
                                    child: AppButtonWithoutCorner(
                                      title: AppStrings.reject.tr,
                                      buttonBackgroundColor: Colors.white,
                                      txtColor: Colors.black,
                                      onPressed: () => onPressed(1),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.h,
                ),
                AppText(
                  textAlign: TextAlign.end,
                  text: getTimeAgoFormat(),
                  color: const Color(0xff6C6C6C),
                  fontFamily: AppStrings.outfitFont,
                  fontWeight: FontWeight.w500,
                  textSize: 12.sp,
                ),
              ],
            ),
            SizedBox(
              height: lastIndexId == item.bookingId ? 0 : 16.h,
            ),
            Container(
              color: const Color(0xff7E7B7B),
              height: lastIndexId == item.bookingId ? 0 : 1,
            ),
          ],
        ),
      ],
    );
  }

  String getImageBasedOnStatus() {
    // 0 = new booking, 1 = approved, 2 = rejected
    switch (item.acceptStatus) {
      case 'new':
        {
          return '';
        }
      case 'yes':
        {
          return AppImages.imgApproved;
        }
      case 'no':
        {
          return AppImages.imgRejected;
        }
      default:
        {
          return '';
        }
    }
  }

  String getTimeAgoFormat() {
    try {
      return timeago.format(
          DateFormat("dd-MMM-yyyy HH:mm:ss").parse(item.bookingDate),
          locale: language == AppStrings.english ? 'en' : 'de');
    } catch (e) {
      return '';
    }
  }
}
