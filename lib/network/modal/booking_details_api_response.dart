
class BookingDetailsApiResponse {
  BookingDetailsApiResponse({
    this.statusCode = 0,
    this.status = '',
    this.bookingInfo,
    this.message = '',
  });

  int statusCode;
  String status;
  BookingDetails? bookingInfo;
  String message;

  factory BookingDetailsApiResponse.fromJson(Map<String, dynamic> json) => BookingDetailsApiResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? '',
    bookingInfo: json["booking_info"] == null ? null : BookingDetails.fromJson(json["booking_info"]),
    message: json["message"] ?? '',
  );

}

class BookingDetails {
  BookingDetails({
    this.bookingId = 0,
    this.customerName = '',
    this.customerEmail  = '',
    this.phoneNumber = '',
    this.desiredModel = '',
    this.desiredDate = '',
    this.desiredTime = '',
    this.duration = '',
    this.contactMode = '',
    this.location = '',
    this.aboutCustomer = '',
    this.bookingDate = '',
    this.acceptStatus = '',
    this.paymentStatus = '',
    this.paymentDateAndTime = '',
    this.paymentMode = '',
    this.bookingStatus = '',
  });

  int bookingId;
  String customerName;
  String customerEmail;
  String phoneNumber;
  String desiredModel;
  String desiredDate;
  String desiredTime;
  String duration;
  String contactMode;
  String location;
  String aboutCustomer;
  String bookingDate;
  String acceptStatus;
  String paymentStatus;
  String paymentDateAndTime;
  String paymentMode;
  String bookingStatus;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    bookingId: json["booking_id"] ?? '',
    customerName: json["customer_name"] ?? '',
    customerEmail: json["customer_email"] ?? '',
    phoneNumber: json["phone_number"] ?? '',
    desiredModel: json["desired_model"] ?? '',
    desiredDate: json["desired_date"] ?? '',
    desiredTime: json["desired_time"] ?? '',
    duration: json["duration"] ?? '',
    contactMode: json["contact_mode"] ?? '',
    location: json["location"] ?? '',
    aboutCustomer: json["about_customer"] ?? '',
    bookingDate: json["booking_date"] ?? '',
    acceptStatus: json["accept_status"] ?? '',
    paymentStatus: json["payment_status"] ?? '',
    paymentDateAndTime: json["payment_date_and_time"] ?? '',
    paymentMode: json["payment_mode"] ?? '',
    bookingStatus: json["booking_status"] ?? '',
  );


}
