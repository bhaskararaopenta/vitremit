// To parse this JSON data, do
//
//     final partnerRatesModel = partnerRatesModelFromJson(jsonString);

import 'dart:convert';

PartnerRatesModel partnerRatesModelFromJson(String str) => PartnerRatesModel.fromJson(json.decode(str));

String partnerRatesModelToJson(PartnerRatesModel data) => json.encode(data.toJson());

class PartnerRatesModel {
  bool success;
  String message;
  Response response;

  PartnerRatesModel({
    required this.success,
    required this.message,
    required this.response,
  });

  factory PartnerRatesModel.fromJson(Map<String, dynamic> json) => PartnerRatesModel(
    success: json["success"],
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  String amountToConvert;
  String conversionRate;
  String platformFee;
  String receiveAmount;
  String shouldArrive;
  String totalFees;

  Response({
    required this.amountToConvert,
    required this.conversionRate,
    required this.platformFee,
    required this.receiveAmount,
    required this.shouldArrive,
    required this.totalFees,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    amountToConvert: json["amount_to_convert"].toString(),
    conversionRate: json["master_rate"].toString(),
    platformFee: json["platform_fee"].toString(),
    receiveAmount: json["amount"].toString(),
    shouldArrive: json["should_arrive"],
    totalFees: json["total_Fees"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "amount_to_convert": amountToConvert,
    "master_rate": conversionRate,
    "platform_fee": platformFee,
    "receive_amount": receiveAmount,
    "should_arrive": shouldArrive,
    "total_Fees": totalFees,
  };
}
