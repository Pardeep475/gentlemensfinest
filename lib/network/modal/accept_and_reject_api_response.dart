import 'notification_api_response.dart';

class AcceptAndRejectApiResponse {
  AcceptAndRejectApiResponse({
    this.statusCode = 0,
    this.status = '',
    this.bookingInfo,
    this.message = '',
  });

  int statusCode;
  String status;
  BookingInfo? bookingInfo;
  String message;

  factory AcceptAndRejectApiResponse.fromJson(Map<String, dynamic> json) =>
      AcceptAndRejectApiResponse(
        statusCode: json["statusCode"] ?? 0,
        status: json["status"] ?? '',
        bookingInfo: json["booking_info"] == null
            ? null
            : BookingInfo.fromJson(json["booking_info"]),
        message: json["message"] ?? '',
      );
}
