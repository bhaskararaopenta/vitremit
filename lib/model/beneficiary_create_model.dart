// To parse this JSON data, do
//
//     final beneficiaryListModel = beneficiaryListModelFromJson(jsonString);

import 'dart:convert';

BeneficiaryCreateModel beneficiaryListModelFromJson(String str) => BeneficiaryCreateModel.fromJson(json.decode(str));

String beneficiaryListModelToJson(BeneficiaryCreateModel data) => json.encode(data.toJson());

class BeneficiaryCreateModel {
  Data data;
  bool success;

  BeneficiaryCreateModel({
    required this.data,
    required this.success,
  });

  factory BeneficiaryCreateModel.fromJson(Map<String, dynamic> json) => BeneficiaryCreateModel(
    data: Data.fromJson(json["beneficiaryDetails"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "beneficiaryDetails": data,
    "success": success,
  };
}

class Data {
  String beneAddress;
  String beneCity;
  String beneDateOfBirth;
  String beneEmail;
  String beneFirstName;
  int beneId;
  String beneLastName;
  String beneMobileNumber;
  String benificiaryCountry;
  String? createdAt;
  int partnerId;
  int? paymentType;
  int remitterId;
  String? updatedAt;

  Data({
    required this.beneAddress,
    required this.beneCity,
    required this.beneDateOfBirth,
    required this.beneEmail,
    required this.beneFirstName,
    required this.beneId,
    required this.beneLastName,
    required this.beneMobileNumber,
    required this.benificiaryCountry,
    required this.createdAt,
    required this.partnerId,
    this.paymentType,
    required this.remitterId,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    beneAddress: json["bene_address"],
    beneCity: json["bene_city"],
    beneDateOfBirth: json["bene_date_of_birth"],
    beneEmail: json["bene_email"],
    beneFirstName: json["bene_first_name"],
    beneId: json["bene_id"]??0,
    beneLastName: json["bene_last_name"],
    beneMobileNumber: json["bene_mobile_number"],
    benificiaryCountry: json["benificiary_country"],
    createdAt: json["created_at"],
    partnerId: json["partner_id"],
    paymentType: json["payment_type"],
    remitterId: json["remitter_id"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "bene_address": beneAddress,
    "bene_city": beneCity,
    "bene_date_of_birth": beneDateOfBirth,
    "bene_email": beneEmail,
    "bene_first_name": beneFirstName,
    "bene_id": beneId,
    "bene_last_name": beneLastName,
    "bene_mobile_number": beneMobileNumber,
    "benificiary_country": benificiaryCountry,
    "created_at": createdAt,
    "partner_id": partnerId,
    "payment_type": paymentType,
    "remitter_id": remitterId,
    "updated_at": updatedAt,
  };
}