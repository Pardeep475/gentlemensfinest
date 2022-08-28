import 'dart:convert';

Escort escortResponseFromJson(String str) => Escort.fromJson(json.decode(str));

String escortResponseToJson(Escort data) => json.encode(data.toJson());

class LoginApiResponse {
  LoginApiResponse({
    this.statusCode = 0,
    this.status = '',
    this.escort,
    this.message = '',
  });

  int statusCode;
  String status;
  Escort? escort;
  String message;

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) => LoginApiResponse(
    statusCode: json["statusCode"] ?? 0,
    status: json["status"] ?? '',
    escort: json["escort"] == null ? null : Escort.fromJson(json["escort"]),
    message: json["message"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "escort": escort == null ? null : escort!.toJson(),
    "message": message,
  };
}

class Escort {
  Escort({
    this.escortId = 0,
    this.token = '',
    this.name = '',
  });

  int escortId;
  String token;
  String name;

  factory Escort.fromJson(Map<String, dynamic> json) => Escort(
    escortId: json["escort_id"],
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "escort_id": escortId,
    "token": token,
    "name": name,
  };
}
