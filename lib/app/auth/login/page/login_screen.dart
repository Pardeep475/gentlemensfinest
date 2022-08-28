import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gentleman_finest/app/auth/login/controller/login_controller.dart';
import 'package:gentleman_finest/common/app_color.dart';
import 'package:gentleman_finest/common/app_images.dart';
import 'package:gentleman_finest/common/app_strings.dart';
import 'package:gentleman_finest/common/widget/app_text.dart';
import 'package:get/get.dart';
import '../../../../common/widget/app_button.dart';
import '../../../../common/widget/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController _controller = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.imgLoginBackground),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48.h,
                      ),
                      AppText(
                        text: AppStrings.gentlemanDescription.tr,
                        color: AppColor.white,
                        lineHeight: 1.2,
                        fontFamily: AppStrings.interFont,
                        fontWeight: FontWeight.w700,
                        textSize: 25.sp,
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      AppTextField(
                        placeHolder: AppStrings.enterYourEmail.tr,
                        controller: _emailController,
                        validator: (value) =>
                            _controller.validateEmail(value: value),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AppTextField(
                        placeHolder: AppStrings.enterYourPassword.tr,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) =>
                            _controller.validatePassword(value: value),
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      AppButton(
                        txt: AppStrings.login.tr,
                        onPressed: () => _loginClickListener(),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned.fill(
              child: _controller.showLoader.value
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

  _loginClickListener() {
    if (_formGlobalKey.currentState!.validate()) {
      _controller.fetchUserResponseApi(
          userName: _emailController.text.toString(),
          password: _passwordController.text.toString());
    }
  }
}
