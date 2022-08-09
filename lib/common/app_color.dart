import 'dart:ui';

class AppColor {
  static final AppColor _appColor = AppColor._internal();

  factory AppColor() {
    return _appColor;
  }

  AppColor._internal();

  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFFF0303);
  static const hintColor = Color(0xFF8391A1);
  static const outlineBorderColor = Color(0xFFE8ECF4);
  static const textFieldFillColor = Color(0xFFF7F8F9);
  static const buttonFillColor = Color(0xFF1E232C);

}
