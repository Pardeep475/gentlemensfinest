import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/app_strings.dart';
import '../../common/utils.dart';

class NotificationApiResponse {
  NotificationApiResponse({
    this.statusCode = 0,
    this.status = '',
    this.bookingInfo,
    this.message = '',
  });

  int statusCode;
  String status;
  List<BookingInfo>? bookingInfo;
  String message;

  factory NotificationApiResponse.fromJson(Map<String, dynamic> json) =>
      NotificationApiResponse(
        statusCode: json["statusCode"] ?? 0,
        status: json["status"] ?? '',
        bookingInfo: json["booking_info"] == null
            ? null
            : List<BookingInfo>.from(
                json["booking_info"].map((x) => BookingInfo.fromJson(x))),
        message: json["message"] ?? '',
      );
}

class BookingInfo {
  BookingInfo({
    this.bookingId = 0,
    this.customerName = '',
    this.aboutCustomer = '',
    this.bookingDate = '',
    this.acceptStatus = '',
    this.bookingStatus = '',
    this.groupBy = '',
  });

  int bookingId;
  String customerName;
  String aboutCustomer;
  String bookingDate;
  String acceptStatus;
  String bookingStatus;
  String groupBy;

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    String parseGroupBy(String value) {
      if (value.isEmpty) {
        return '';
      }
      var dateTime = DateFormat("dd-MMM-yyyy HH:mm:ss").parse(value);
      if(Utils.isSameDateFromDateTime(dateTime)){
        return AppStrings.today;
      } else if(Utils.checkIfDatesExistInCurrentWeek(dateTime)){
        return AppStrings.thisWeek;
      } else {
        return AppStrings.older;
      }
    }

    return BookingInfo(
      bookingId: json["booking_id"] ?? 0,
      customerName: json["customer_name"] ?? '',
      aboutCustomer: json["about_customer"] ?? '',
      bookingDate: json["booking_date"] ?? '',
      acceptStatus: json["accept_status"] ?? '',
      bookingStatus: json["booking_status"] ?? '',
      groupBy: parseGroupBy(json["booking_date"] ?? ''),
    );
  }
}
