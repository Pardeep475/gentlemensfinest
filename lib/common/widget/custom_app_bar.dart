import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/common/app_images.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onHamburgerPressed;

  const CustomAppBar({
    required this.onHamburgerPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.imgLogoGentlemen,
          height: 57.h,
          width: 220.w,
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: onHamburgerPressed,
          child: Image.asset(
            AppImages.iconHamburgerPng,
            height: 24.r,
            width: 24.r,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
