import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gentleman_finest/common/app_color.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:get/get.dart';

import '../../../common/app_strings.dart';
import '../../../common/utils.dart';
import '../../../common/widget/app_text.dart';
import 'item_child_login.dart';
import 'item_header_dialog.dart';
import 'item_logout.dart';

class ItemLoginProfile extends StatelessWidget {
  const ItemLoginProfile({Key? key}) : super(key: key);

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
                  onBackPressed: () {},
                ),
                ItemChildLogin(
                  title: AppStrings.requestsAcceptedLists.tr,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildLogin(
                    title: AppStrings.requestsAcceptedLists.tr,
                    onPressed: () {
                      debugPrint('1 clicked');
                    }),
                const ItemLogout(),
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
}
