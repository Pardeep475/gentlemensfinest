import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gentleman_finest/common/app_color.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:gentleman_finest/common/local_storage/session_manager.dart';
import 'package:gentleman_finest/common/services/localization_service.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/app_text.dart';
import '../controller/dashboard_controller.dart';
import 'item_child_login.dart';
import 'item_header_dialog.dart';
import 'item_logout.dart';

class ItemLoginProfile extends StatelessWidget {
  const ItemLoginProfile({required this.controller, Key? key})
      : super(key: key);
  final DashboardController controller;

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
                  title: AppStrings.loggedInHeidi.tr,
                  onBackPressed: () => controller.updateHamburgerPressed(false),
                ),
                ItemChildLogin(
                  title: AppStrings.requestsAllNotificationLists.tr,
                  onPressed: () {
                    debugPrint('1 clicked');
                    controller.updateHamburgerPressed(false);
                    controller.updateNotificationType(0);
                    controller.fetchNotificationApi(
                        acceptList: 1, rejectList: 1);
                  },
                ),
                ItemChildLogin(
                  title: AppStrings.requestsAcceptedLists.tr,
                  onPressed: () {
                    debugPrint('1 clicked');
                    controller.updateHamburgerPressed(false);
                    controller.updateNotificationType(1);
                    controller.fetchNotificationApi(
                        acceptList: 'yes', rejectList: 'no');
                  },
                ),
                ItemChildLogin(
                    title: AppStrings.requestsRejectedLists.tr,
                    onPressed: () {
                      debugPrint('1 clicked');
                      controller.updateHamburgerPressed(false);
                      controller.updateNotificationType(2);
                      controller.fetchNotificationApi(
                          acceptList: 'no', rejectList: 'yes');
                    }),
                ItemChildLogin(
                    title: AppStrings.changeLanguage.tr,
                    onPressed: () {
                      debugPrint('1 clicked');
                      openChangeLanguageDialog(context: context);
                    }),
                ItemLogout(
                  onLogoutPressed: () async {
                    await SessionManager.clearAllData();
                    Get.offAndToNamed(RouteString.loginScreen);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: Utils.appBarHeightMargin,
          ),
        ],
      ),
    );
  }

  openChangeLanguageDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: [
                      ItemHeaderDialog(
                        title: AppStrings.changeLanguage.tr,
                        onBackPressed: () => Navigator.pop(context),
                      ),
                      ItemChildLogin(
                          title: AppStrings.englishLanguage.tr,
                          onPressed: () {
                            SessionManager.setLanguage(AppStrings.english);
                            LocalizationService service = LocalizationService();
                            service.changeLocale(AppStrings.english);
                            Navigator.pop(context);
                          }),
                      ItemChildLogin(
                          title: AppStrings.germanLanguage.tr,
                          onPressed: () {
                            SessionManager.setLanguage(AppStrings.german);
                            LocalizationService service = LocalizationService();
                            service.changeLocale(AppStrings.german);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
