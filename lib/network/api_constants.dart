class ApiConstants {
  static final ApiConstants _apiConstants = ApiConstants._internal();

  factory ApiConstants() {
    return _apiConstants;
  }

  ApiConstants._internal();
  // live
  static String baseUrl = "https://amitjana.com/gentlemens/wp-json/api/";
  // local
  // static String baseUrl = "http://3190-2405-201-300b-38-85cd-c84c-4b95-dd45.ngrok.io";


  // live
  static String onLoginApi = "${baseUrl}escort-login";


  // development
  // static String onBoardingApi = "${baseUrl}onBoardingApi";
  // static String userRegistration = "${baseUrl}user-registration";
  // static String contactUs = "${baseUrl}contact-us";
  // static String editUser = "${baseUrl}edit-user/";
  // static String addReview = "${baseUrl}addReview";
  // static String homePropertyListing = "${baseUrl}getHomePropertyListing";
  // static String allPropertyListing = "${baseUrl}getPropertyListing";

}
