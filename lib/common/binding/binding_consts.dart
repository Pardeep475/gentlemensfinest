class BindingConst {
  static final BindingConst _bindingConst = BindingConst._internal();

  factory BindingConst() {
    return _bindingConst;
  }

  BindingConst._internal();

  static const String splashScreenBinding = "SPLASH_SCREEN_BINDING";
  static const String loginScreenBinding = "LOGIN_SCREEN_BINDING";
  static const String dashboardScreenBinding = "DASHBOARD_SCREEN_BINDING";

}