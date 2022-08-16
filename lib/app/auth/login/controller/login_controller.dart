import 'package:gentleman_finest/common/app_strings.dart';
import 'package:get/get.dart';

import '../../../../common/local_storage/session_manager.dart';
import '../../../../common/routes/route_strings.dart';
import '../../../../common/utils.dart';
import '../../../../network/api_provider.dart';
import '../../../../network/modal/login_api_response.dart';

class LoginController extends GetxController {

  var showLoader = false.obs;

  String? validateEmail({required String? value}) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailIsRequired.tr;
    }
    // if (!GetUtils.isEmail(value)) {
    //   return AppStrings.validEmailValidation.tr;
    // }
    return null;
  }

  String? validatePassword({required String? value}) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired.tr;
    }

    return null;
  }

  @override
  void onInit() {
    super.onInit();
    Utils.logger.e("on init");
  }

  @override
  void onReady() {
    super.onReady();
    Utils.logger.e("on ready");
  }

  @override
  void onClose() {
    super.onClose();
    Utils.logger.e("on close");
  }

  Future fetchUserResponseApi(
      {required String userName, required String password}) async {
    bool value = await Utils.checkConnectivity();
    if (value) {
      try {
        showLoader.value = true;
        var response = await ApiProvider.apiProvider
            .loginApi(userName: userName,password: password);
        if (response != null) {
          Escort? userData = (response as LoginApiResponse).escort;
          if(userData != null){
            Utils.logger.e("token_is:-   ${userData.name}");
            SessionManager.setUserData(userData);
            SessionManager.setLogin(true);
            Get.offAndToNamed(RouteString.dashBoardScreen,);
          }
        }
      } catch (e) {
        Utils.errorSnackBar(AppStrings.error.tr, e.toString());
      } finally {
        showLoader.value = false;
      }
    }
    return null;
  }

}
