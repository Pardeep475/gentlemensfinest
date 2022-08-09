import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gentleman_finest/network/modal/login_api_response.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';
import '../common/app_strings.dart';
import '../common/local_storage/session_manager.dart';
import '../common/utils.dart';
import 'api_constants.dart';
import 'logging_interceptor.dart';
import 'modal/add_and_remove_watch_list_api_response.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class ApiProvider {
  static final ApiProvider apiProvider = ApiProvider._internal();

  factory ApiProvider() {
    _dio.interceptors.add(LoggingInterceptor());
    return apiProvider;
  }

  ApiProvider._internal();

  static final sessionToken = Uuid().v4();

  static BaseOptions options =
      BaseOptions(receiveTimeout: 90000000, connectTimeout: 90000000);

  static final Dio _dio = Dio(options);

  Future<dynamic> loginApi(
      {required String userName, required String password}) async {
    try {
      var map = <String, dynamic>{};
      map['username'] = userName;
      map['password'] = password;
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.german) {
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

/*Future<dynamic> userRegistrationApi({dynamic data}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Response response = await _dio.post(ApiConstants.userRegistration,
          data: data, options: headerOptions);
      UserModalApiResponse userModalApiResponse =
          UserModalApiResponse.fromJson(response.data);
      if (userModalApiResponse.status) {
        return userModalApiResponse.data;
      } else {
        Utils.errorSnackBar(AppStrings.error, userModalApiResponse.message);
        return null;
      }
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return null;
    }
  }

  Future<dynamic> contactUsApi({dynamic data}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Response response = await _dio.post(ApiConstants.contactUs,
          data: data, options: headerOptions);
      return response.data;
    } catch (error) {
      Utils.errorSnackBar(AppStrings.error, error.toString());
      return UserModalApiResponse(status: false, message: error.toString());
    }
  }

  Future<dynamic> editUserApi(
      {required String id, required dynamic loginModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.put("${ApiConstants.editUser}$id",
          data: loginModal, options: headerOptions);
      return response.data;
    } catch (error) {
      return UserModalApiResponse(status: false, message: error.toString());
    }
  }

  Future<dynamic> uploadImageApi({required List<String> images}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(contentType: "multipart/form-data", headers: {
        'language': lang,
      });
      var formData = FormData();
      for (int i = 0; i < images.length; i++) {
        formData.files.add(
          MapEntry(
            "photos[$i]",
            await MultipartFile.fromFile(
              images[i],
              filename: File(images[i]).path.split('/').last,
              contentType: MediaType('image', 'jpg'),
            ),
          ),
        );
      }
      Response response = await _dio.post(ApiConstants.uploadFiles,
          data: formData, options: headerOptions);
      return response.data;
    } catch (error) {
      return UserModalApiResponse(status: false, message: error.toString());
    }
  }

  Future<dynamic> uploadMultipleFiles(
      {required List<String?> images,
      required OnUploadProgressCallback onUploadProgress}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(contentType: "multipart/form-data", headers: {
        'language': lang,
      });
      var formData = FormData();
      for (int i = 0; i < images.length; i++) {
        final String? mimeType = lookupMimeType(images[i]!);
        if (mimeType != null) {
          List<String> outputMineType = mimeType.split("/");
          if (outputMineType.length == 2) {
            String type = outputMineType[0];
            String subType = outputMineType[1];
            formData.files.add(
              MapEntry(
                "photos[$i]",
                await MultipartFile.fromFile(
                  images[i]!,
                  filename: File(images[i]!).path.split('/').last,
                  // contentType: MediaType('image', 'jpg'),
                  contentType: MediaType(type, subType),
                ),
              ),
            );
          }
        }
      }
      // video/mp4
      Response response = await _dio.post(ApiConstants.uploadFiles,
          data: formData,
          options: headerOptions,
          onSendProgress: onUploadProgress);
      return response.data;
    } catch (error) {
      return UserModalApiResponse(status: false, message: error.toString());
    }
  }

  Future<dynamic> addReviewApi({required dynamic addReviewModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   $addReviewModal");
      Response response = await _dio.post(ApiConstants.addReview,
          data: addReviewModal, options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> editReviewApi({required dynamic addReviewModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.post(ApiConstants.editReview,
          data: addReviewModal, options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> removeMyListingApi({required String propertyId}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.delete(
          ApiConstants.removeProperty + propertyId,
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getHomeApi({required HomeModal homeModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Utils.logger.e("home_modal:-    ${homeModalToJson(homeModal)}");
      Response response = await _dio.post(ApiConstants.homePropertyListing,
          data: homeModalToJson(homeModal), options: headerOptions);
      return response.data;
    } catch (error) {
      return HomeApiResponse(success: false, message: error.toString());
    }
  }

  // createdBy=7dAP23Yk4OnqGI6Aaaie
  Future<dynamic> getAllApi({
    required FilterModal filterModal,
    required int limit,
    required int offset,
  }) async {
    try {
      debugPrint("all api:-  ${filterModalToJson(filterModal)}");

      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });

      Utils.logger.e("all_listing:-  ${filterModalToJson(filterModal)}");

      String url =
          "${ApiConstants.allPropertyListing}?limit=$limit&offset=$offset";
      Response response = await _dio.post(url,
          options: headerOptions, data: filterModalToJson(filterModal));
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getViewAllListing(
      {required int limit,
      required int offset,
      required FilterModal filterModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      // category=$category&type=$type
      String url =
          "${ApiConstants.getPropertyListingByRecommendation}?limit=$limit&offset=$offset";
      Response response = await _dio.post(url,
          options: headerOptions, data: filterModalToJson(filterModal));
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getShortListedApi({
    required String category,
    required int limit,
    required int offset,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      var url =
          "${ApiConstants.myWishList}?category=$category&limit=$limit&offset=$offset";
      Utils.logger.e("mywishlistapiurl:-   $url");
      Response response = await _dio.get(url, options: headerOptions);

      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getMyReviews({
    required int limit,
    required int offset,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      var url = "${ApiConstants.myReviews}?limit=$limit&offset=$offset";
      Response response = await _dio.get(url, options: headerOptions);
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getAllReviews(
      {required int limit,
      required int offset,
      required String createdBy}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      var url =
          "${ApiConstants.allReviews}?limit=$limit&offset=$offset&userId=$createdBy";
      Response response = await _dio.get(url, options: headerOptions);
      return response.data;
    } catch (error) {
      return AllReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getMyListing(
      {required int limit,
      required int offset,
      required String createdBy}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      // &createdBy=$createdBy
      var url =
          "${ApiConstants.allPropertyListing}?limit=$limit&offset=$offset";
      Response response = await _dio
          .post(url, options: headerOptions, data: {"createdBy": createdBy});
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getSearchApi(
      {required int limit,
      required int offset,
      required SearchModal searchModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      var url =
          "${ApiConstants.getSearchPropertyListing}?limit=$limit&offset=$offset";
      Response response = await _dio.post(url,
          options: headerOptions, data: searchModalToJson(searchModal));
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getAgentListing({
    required String agentId,
    required int limit,
    required int offset,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      UserModal? userData = await Utils.getUserData();
      String userId = "";
      if (userData != null) {
        userId = userData.id ?? "";
      }
      var data = {
        "userId": userId,
        "createdBy": agentId,
      };
      Response response = await _dio.post(
          "${ApiConstants.allPropertyListing}?limit=$limit&offset=$offset",
          options: headerOptions,
          data: data);
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getSimilarListingApi({
    required HomeModal homeModal,
    required int limit,
    required int offset,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Response response = await _dio.post(
          "${ApiConstants.similarListing}?limit=$limit&offset=$offset",
          options: headerOptions,
          data: homeModalToJson(homeModal));
      return response.data;
    } catch (error) {
      return PropertyListApiResponse(success: false, message: error.toString());
    }
  }

  //agentProfile
  Future<dynamic> getAgentProfileApi({
    required String id,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }

      UserModal? userData = await Utils.getUserData();
      String userId = "";
      // loggedinUserId
      if (userData != null) {
        userId = userData.id ?? "";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      // eWuQapPmiibWUZQA6VLg?loggedinUserId=AwAmS9cFCoSyaWxeHDvn
      //eWuQapPmiibWUZQA6VLg/AwAmS9cFCoSyaWxeHDvn
      Response response = await _dio.get(
          "${ApiConstants.agentProfile}$id/$userId".trim(),
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AgentProfileApiResponse(success: false, message: error.toString());
    }
  }

  //agentProfile
  Future<dynamic> getUserProfileApi() async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      String userId = "";
      if (userData != null) {
        userId = userData.id ?? "";
      }
      var headerOptions = Options(headers: {
        'language': lang,
      });
      Response response = await _dio.get(
          "${ApiConstants.agentProfile}$userId".trim(),
          options: headerOptions);
      return response.data;
    } catch (error) {
      return UserModalApiResponse(status: false, message: error.toString());
    }
  }

  Future<dynamic> updateWatchList({
    required AddOrRemoveWatchList addOrRemoveWatchList,
  }) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.post(ApiConstants.addOrRemoveToWishlist,
          data: addOrRemoveWatchListToJson(addOrRemoveWatchList),
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AddAndRemoveWatchListApiResponse(
          success: false, message: error.toString());
    }
  }

  Future<dynamic> addPropertyApi({required dynamic addEditModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.post(ApiConstants.addProperty,
          data: addEditModal, options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> editPropertyApi({required AddEditModal addEditModal}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.put(
          "${ApiConstants.editProperty}${addEditModal.postId}",
          data: addEditModalToJson(addEditModal),
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> updateDeviceToken() async {
    try {
      String? deviceToken = await SessionManager.getFirebaseToken();
      if (GetUtils.isNullOrBlank(deviceToken)!) {
        String? token = await NotificationService.getToken();
        if (token == null) return;
        deviceToken = token;
      }

      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.post(ApiConstants.updateDeviceToken,
          data: {"deviceToken": deviceToken}, options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  // {"createdBy": createdBy}
  Future<dynamic> getAllNotification({
    required int limit,
    required int offset,
  }) async {
    try {
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.get(
          "${ApiConstants.getAllNotification}?limit=$limit&offset=$offset",
          options: headerOptions);
      return response.data;
    } catch (error) {
      return NotificationApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> clearAllNotification() async {
    try {
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.post(ApiConstants.clearAllNotification,
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> clearSingleNotification(
      {required String notificationId}) async {
    try {
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      Response response = await _dio.put(
          "${ApiConstants.clearSingleNotification}$notificationId",
          options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }

  Future<dynamic> getPropertyById({required String propertyId}) async {
    try {
      String language = await SessionManager.getLanguage();
      String lang = "en";
      String userId = "";
      if (language == AppStrings.somali) {
        lang = "so";
      }
      UserModal? userData = await Utils.getUserData();
      if (userData == null) return;
      userId = userData.id ?? "";
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer ${userData.token ?? ""}',
        'language': lang,
      });
      Utils.logger.e("token_is:-   ${userData.token}");
      String url = "${ApiConstants.fetchPropertyDetailById}/$propertyId";
      Response response = await _dio.post(url,
          data: {"userId": userId}, options: headerOptions);
      return response.data;
    } catch (error) {
      return AddReviewApiResponse(success: false, message: error.toString());
    }
  }*/

}
