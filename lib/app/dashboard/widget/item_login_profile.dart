import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_color.dart';
import 'package:gentleman_finest/common/local_storage/session_manager.dart';
import 'package:gentleman_finest/common/services/localization_service.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/routes/route_strings.dart';
import '../../../common/utils.dart';
import '../../../network/modal/login_api_response.dart';
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
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.red, width: 0.5.r),
          ),
          child: Column(
            children: [
              FutureBuilder<String>(
                  future: fetchUserName(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ItemHeaderDialog(
                        title: AppStrings.loggedInHeidi.tr + snapshot.data!,
                        onBackPressed: () =>
                            Navigator.pop(context),
                      );
                    }
                    return  ItemHeaderDialog(
                      title: AppStrings.loggedInHeidi.tr,
                      onBackPressed: () =>
                          Navigator.pop(context),
                    );
                  }),
              ItemChildLogin(
                title: AppStrings.requestsAllNotificationLists.tr,
                onPressed: () {
                  debugPrint('1 clicked');
                  controller.updateNotificationType(0);
                  controller.fetchNotificationApi(
                      acceptList: 'yes', rejectList: 'yes');
                  Navigator.pop(context);
                },
              ),
              ItemChildLogin(
                title: AppStrings.requestsAcceptedLists.tr,
                onPressed: () {
                  debugPrint('1 clicked');
                  controller.updateNotificationType(1);
                  controller.fetchNotificationApi(
                      acceptList: 'yes', rejectList: 'no');
                  Navigator.pop(context);
                },
              ),
              ItemChildLogin(
                  title: AppStrings.requestsRejectedLists.tr,
                  onPressed: () {
                    debugPrint('1 clicked');
                    controller.updateNotificationType(2);
                    controller.fetchNotificationApi(
                        acceptList: 'no', rejectList: 'yes');
                    Navigator.pop(context);
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
    );
  }

  openChangeLanguageDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            // insetPadding:
            // EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                            Navigator.pop(context);
                          }),
                      ItemChildLogin(
                          title: AppStrings.germanLanguage.tr,
                          onPressed: () {
                            SessionManager.setLanguage(AppStrings.german);
                            LocalizationService service = LocalizationService();
                            service.changeLocale(AppStrings.german);
                            Navigator.pop(context);
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

  Future<String> fetchUserName() async {
    Escort? data = await Utils.getUserData();
    if (data == null) {
      return '';
    }
    return data.name;
  }
}
