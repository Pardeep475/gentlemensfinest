import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gentleman_finest/app/dashboard/controller/dashboard_controller.dart';
import 'package:gentleman_finest/common/local_storage/session_manager.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/item_empty_notification.dart';
import '../widget/item_login_profile.dart';
import '../widget/item_logout.dart';
import '../widget/item_profile_screen.dart';
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
              if (_controller.onHamburgerPressed.value ||
                  _controller.itemProfileOpen.value ||
                  _controller.showLoader.value ||
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
                  onHamburgerPressed: () => _controller.updateHamburgerPressed(
                      !_controller.onHamburgerPressed.value),
                ),
                Expanded(
                  child: Obx(() {
                    if (_controller.onHamburgerPressed.value) {
                      return ItemLoginProfile(
                        controller: _controller,
                      );
                    } else if (_controller.itemProfileOpen.value) {
                      return ItemProfileScreen(
                        controller: _controller,
                        bookingInfo: _controller.bookingInfo!,
                      );
                    } else if (_controller.showLoader.value) {
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
}
