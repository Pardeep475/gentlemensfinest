import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/app/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/item_empty_notification.dart';
import '../widget/item_login_profile.dart';
import 'all_notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController _controller =
      Get.isRegistered<DashboardController>()
          ? Get.find<DashboardController>()
          : Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.fetchNotificationApi(acceptList: 1, rejectList: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              if (_controller.showLoader.value ||
                  (!_controller.showLoader.value &&
                      _controller.dataList.isEmpty)) {
                return const SizedBox();
              }
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_controller.getNotificationBackground()),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(
                  height: kToolbarHeight * 0.7,
                ),
                CustomAppBar(
                  onHamburgerPressed: () => openLoginDialog(context: context),
                ),
                Expanded(
                  child: Obx(() {
                    if (_controller.showLoader.value) {
                      return const SizedBox();
                    } else if (!_controller.showLoader.value &&
                        _controller.dataList.isEmpty) {
                      return const ItemEmptyNotification();
                    }
                    return AllNotificationScreen(
                      notificationScreenType:
                          _controller.notificationScreenType.value,
                      dataList: _controller.dataList,
                      controller: _controller,
                    );
                  }),
                )
              ],
            ),
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value ||
                      _controller.showLoaderAcceptAndReject.value
                  ? Container(
                      color: Colors.transparent,
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColor.red),
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  openLoginDialog({required BuildContext context}) {
    showDialog(
        context: context,
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
                  child: ItemLoginProfile(
                    controller: _controller,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
