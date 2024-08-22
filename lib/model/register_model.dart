import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool success;
  String? message;
  String? token;
  UserPermissionDetails? userPermissionDetails;
  UserDetails? userDetails;
  Error? error;

  RegisterModel({
    required this.success,
    this.message,
    this.token,
    this.userPermissionDetails,
    this.userDetails,
    this.error,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        userPermissionDetails: json["UserPermissionDetails"] == null
            ? null
            : UserPermissionDetails.fromJson(json["userPermissionDetails"]),
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "userPermissionDetails": userPermissionDetails,
        "userDetails": userDetails,
        "error": error,
      };
}

class Error {
  String message;
  int statusCode;

  Error({
    required this.message,
    required this.statusCode,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
      };
}

class UserDetails {
  String? userName;
  String? firstName;
  String? lastName;
  String? mobileCode;
  String? mobileNumber;
  int? partnerId;
  String? remitterName;
  String? email;
  String kycStatus;
  String amlStatus;
  int? remitterId;
  DateTime? createdAt;

  UserDetails({
    this.userName,
    required this.firstName,
    required this.lastName,
    required this.mobileCode,
    required this.mobileNumber,
    required this.partnerId,
    required this.remitterId,
    required this.remitterName,
    required this.email,
    required this.amlStatus,
    required this.kycStatus,
    this.createdAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        partnerId: json["partner_id"],
        remitterName: json["remitter_name"],
        remitterId: json["remitter_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        userName: json["user_name"],
        kycStatus: json["kyc_status"],
       amlStatus: json["aml_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "email": email,
        "created_at": createdAt,
        "kyc_status": kycStatus,
        "aml_status": amlStatus,
      };
}

class UserPermissionDetails {
  dynamic permissions;
  dynamic sections;

  UserPermissionDetails({
    this.permissions,
    this.sections,
  });

  factory UserPermissionDetails.fromJson(Map<String, dynamic> json) =>
      UserPermissionDetails(
        permissions: json["permissions"],
        sections: json["sections"],
      );

  Map<String, dynamic> toJson() => {
        "permissions": permissions,
        "sections": sections,
      };
}
