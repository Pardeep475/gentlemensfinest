// To parse this JSON data, do
//
//     final addAndRemoveWatchListApiResponse = addAndRemoveWatchListApiResponseFromJson(jsonString);

import 'dart:convert';

AddAndRemoveWatchListApiResponse addAndRemoveWatchListApiResponseFromJson(
        String str) =>
    AddAndRemoveWatchListApiResponse.fromJson(json.decode(str));

String addAndRemoveWatchListApiResponseToJson(
        AddAndRemoveWatchListApiResponse data) =>
    json.encode(data.toJson());

class AddAndRemoveWatchListApiResponse {
  AddAndRemoveWatchListApiResponse({
    this.success = false,
    this.message = "",
  });

  bool success;
  String message;

  factory AddAndRemoveWatchListApiResponse.fromJson(
          Map<String, dynamic> json) =>
      AddAndRemoveWatchListApiResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
