import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_color.dart';
import '../../../common/app_images.dart';
import '../../../common/app_strings.dart';
import 'item_child_profile.dart';
import 'item_header_dialog.dart';

class ItemProfileScreen extends StatelessWidget {
  const ItemProfileScreen({Key? key}) : super(key: key);

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
                  title: AppStrings.detailsFor.tr,
                  onBackPressed: () {},
                ),
                ItemChildProfile(
                  title: '${AppStrings.phone.tr}\n(415) 555 - 3046',
                  icon: AppImages.iconPhone,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: '${AppStrings.email.tr}\nalbert@gmail.com',
                  icon: AppImages.iconEmail,
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.desiredModel.tr,
                  icon: AppImages.iconModal,
                  content:
                      'You Should wear sexy lingerie with stocking matching the same color, minimal make-up.',
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.dateAndTime.tr,
                  icon: AppImages.iconModal,
                  content:
                      '15-july-2022, 12:30 AM Duration - 3 Hours',
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  title: AppStrings.location.tr,
                  icon: AppImages.iconModal,
                  content:
                      'Geneva, Switzerland',
                  onPressed: () {
                    debugPrint('1 clicked');
                  },
                ),
                ItemChildProfile(
                  isDivider: false,
                  title: AppStrings.detailedInfo.tr,
                  icon: AppImages.iconInfo,
                  content:
                      'You Should wear sexy lingerie with stocking matching the same color, minimal make-up.',
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
