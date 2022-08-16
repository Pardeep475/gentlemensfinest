import 'package:dio/dio.dart';
import 'package:gentleman_finest/network/modal/login_api_response.dart';
import 'package:uuid/uuid.dart';
import '../common/app_strings.dart';
import '../common/local_storage/session_manager.dart';
import '../common/utils.dart';
import 'api_constants.dart';
import 'logging_interceptor.dart';
import 'modal/accept_and_reject_api_response.dart';
import 'modal/booking_details_api_response.dart';
import 'modal/notification_api_response.dart';

class ApiProvider {
  static final ApiProvider apiProvider = ApiProvider._internal();

  factory ApiProvider() {
    _dio.interceptors.add(LoggingInterceptor());
    return apiProvider;
  }

  ApiProvider._internal();

  static final sessionToken = const Uuid().v4();

  static BaseOptions options =
      BaseOptions(receiveTimeout: 90000000, connectTimeout: 90000000);

  static final Dio _dio = Dio(options);

  Future<dynamic> loginApi(
      {required String userName, required String password}) async {
    try {
      var map = <String, dynamic>{};
      map['username'] = userName;
      map['password'] = password;
      String? language = await SessionManager.getLanguage();
      String lang = "en";
      if (language != null && language == AppStrings.german) {
        lang = "ge";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Response response = await _dio.post(ApiConstants.onLoginApi,
          data: map, options: headerOptions);
      return LoginApiResponse.fromJson(response.data);
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> getNotificationApi(
      {required dynamic acceptList, required dynamic rejectedList}) async {
    try {
      String? language = await SessionManager.getLanguage();
      String lang = "en";
      if (language != null && language == AppStrings.german) {
        lang = "ge";
      }
      Escort? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        // 'Authorization': 'Bearer ${userData.token}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.get(
          "${ApiConstants.getNotificationApi}?token=${userData.token}&acceptedList=$acceptList&rejectedList=$rejectedList",
          options: headerOptions);
      return NotificationApiResponse.fromJson(response.data).bookingInfo;
    } catch (error) {
      return NotificationApiResponse(statusCode: 0, message: error.toString());
    }
  }

  Future<dynamic> getBookingDetailsApi({required int bookingId}) async {
    try {
      String? language = await SessionManager.getLanguage();
      String lang = "en";
      if (language != null && language == AppStrings.german) {
        lang = "ge";
      }
      Escort? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        // 'Authorization': 'Bearer ${userData.token}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      var map = <String, dynamic>{};
      map['token'] = userData.token;
      map['booking'] = bookingId;
      Response response = await _dio.post(ApiConstants.getBookingDetailsApi,
          data: map, options: headerOptions);
      return BookingDetailsApiResponse.fromJson(response.data).bookingInfo;
    } catch (error) {
      return BookingDetailsApiResponse(
          statusCode: 0, message: error.toString());
    }
  }

  Future<dynamic> acceptAndRejectApi(
      {required int bookingId, required dynamic acceptReject}) async {
    try {
      String? language = await SessionManager.getLanguage();
      String lang = "en";
      if (language != null && language == AppStrings.german) {
        lang = "ge";
      }
      Escort? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        // 'Authorization': 'Bearer ${userData.token}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      var map = <String, dynamic>{};
      map['token'] = userData.token;
      map['accept_reject'] = acceptReject;
      map['booking'] = bookingId;
      Response response = await _dio.post(ApiConstants.acceptAndRejectApi,
          data: map, options: headerOptions);
      return AcceptAndRejectApiResponse.fromJson(response.data).bookingInfo;
    } catch (error) {
      return AcceptAndRejectApiResponse(
          statusCode: 0, message: error.toString());
    }
  }
}
