import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import '../../../common/widget/app_text.dart';
import '../../../common/widget/custom_app_bar.dart';
import '../../../common/widget/item_empty_notification.dart';
import '../widget/item_login_profile.dart';
import '../widget/item_profile_screen.dart';
import 'all_notification_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: AppText(
                textAlign: TextAlign.start,
                text: 'Albert Huston',
                color: Colors.black,
                fontFamily: AppStrings.outfitFont,
                fontWeight: FontWeight.w700,
                textSize: 15.sp,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
        elevation: 1,
      ),
      // drawerScrimColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.imgRejectedBackground),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(
                  height: kToolbarHeight * 0.7,
                ),
                CustomAppBar(
                  onHamburgerPressed: () {
                    debugPrint('click:---- - -- - - - - -');
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
                const Expanded(
                  child: AllNotificationScreen(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
