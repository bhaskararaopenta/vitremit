// To parse this JSON data, do
//
//     final createTransactionModel = createTransactionModelFromJson(jsonString);

import 'dart:convert';

CreateTransactionModel createTransactionModelFromJson(String str) =>
    CreateTransactionModel.fromJson(json.decode(str));

String createTransactionModelToJson(CreateTransactionModel data) =>
    json.encode(data.toJson());

class CreateTransactionModel {
  String message;
  bool success;
  Data data;

  CreateTransactionModel({
    required this.message,
    required this.success,
    required this.data,
  });

  factory CreateTransactionModel.fromJson(Map<String, dynamic> json) =>
      CreateTransactionModel(
        message: json["Message"],
        success: json["Success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Success": success,
        "data": data.toJson(),
      };
}

class Data {
  BeneficiaryData beneficiaryData;
  String? token;
  TransactionData transactionData;
  TrustPaymentData? trustPaymentData;
  SettlementAccountInfo? settlementAccountInfo;

  Data({
    required this.beneficiaryData,
    this.token,
    required this.transactionData,
    this.trustPaymentData,
    this.settlementAccountInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        beneficiaryData: BeneficiaryData.fromJson(json["beneficiaryData"]),
        token: json["token"],
        transactionData: TransactionData.fromJson(json["transactionData"]),
        trustPaymentData: json["trustPaymentData"] == null
            ? null
            : TrustPaymentData.fromJson(json["trustPaymentData"]),
        settlementAccountInfo: json["settlement_account_info"] == null
            ? null
            : SettlementAccountInfo.fromJson(json["settlement_account_info"]),
      );

  Map<String, dynamic> toJson() => {
        "beneficiaryData": beneficiaryData,
        "token": token,
        "transactionData": transactionData,
        "trustPaymentData": trustPaymentData,
        "settlementAccountInfo": settlementAccountInfo,
      };
}

class TrustPaymentData {
  String allurlnotification;
  String clientName;
  String currentTimeStamp;
  String declinedurlnotification;
  String declinedurlredirect;
  String errorurlredirect;
  String hash;
  String siteReference;
  String successfulurlnotification;
  String successfulurlredirect;
  String? webviewurl;

  TrustPaymentData({
    required this.allurlnotification,
    required this.clientName,
    required this.currentTimeStamp,
    required this.declinedurlnotification,
    required this.declinedurlredirect,
    required this.errorurlredirect,
    required this.hash,
    required this.siteReference,
    required this.successfulurlnotification,
    required this.successfulurlredirect,
    required this.webviewurl,
  });

  factory TrustPaymentData.fromJson(Map<String, dynamic> json) =>
      TrustPaymentData(
        allurlnotification: json["allurlnotification"],
        clientName: json["clientName"],
        currentTimeStamp: json["currentTimeStamp"],
        declinedurlnotification: json["declinedurlnotification"],
        declinedurlredirect: json["declinedurlredirect"],
        errorurlredirect: json["errorurlredirect"],
        hash: json["hash"],
        siteReference: json["siteReference"],
        successfulurlnotification: json["successfulurlnotification"],
        successfulurlredirect: json["successfulurlredirect"],
        webviewurl: json["webviewurl"],
      );

  Map<String, dynamic> toJson() => {
        "allurlnotification": allurlnotification,
        "clientName": clientName,
        "currentTimeStamp": currentTimeStamp,
        "declinedurlnotification": declinedurlnotification,
        "declinedurlredirect": declinedurlredirect,
        "errorurlredirect": errorurlredirect,
        "hash": hash,
        "siteReference": siteReference,
        "successfulurlnotification": successfulurlnotification,
        "successfulurlredirect": successfulurlredirect,
        "webviewurl": webviewurl,
      };
}

class SettlementAccountInfo {
  String bankName;
  String bankCountry;
  String accountNumber;
  String bankBrachCode;
  String accountHolderName;

  SettlementAccountInfo({
    required this.bankName,
    required this.bankCountry,
    required this.accountNumber,
    required this.bankBrachCode,
    required this.accountHolderName,
  });

  factory SettlementAccountInfo.fromJson(Map<String, dynamic> json) =>
      SettlementAccountInfo(
        bankName: json["bank_name"],
        bankCountry: json["bank_country"],
        accountNumber: json["account_number"],
        bankBrachCode: json["bank_brach_code"],
        accountHolderName: json["account_holder_name"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankCountry": bankCountry,
        "accountNumber": accountNumber,
        "bankBrachCode": bankBrachCode,
        "accountHolderName": accountHolderName,
      };
}

class BeneficiaryData {
  int beneId;
  String beneFirstName;
  String beneMiddleName;
  String beneLastName;
  String beneEmail;
  String beneDateOfBirth;
  String beneMobileNumber;
  String beneAddress;
  String beneCity;
  String benificiaryCountry;
  int paymentType;
  bool isactive;
  int remitterId;
  int partnerId;
  String beneCardNumber;
  BeneBankDetails? beneBankDetails;
  DateTime createdAt;
  DateTime updatedAt;

  BeneficiaryData({
    required this.beneId,
    required this.beneFirstName,
    required this.beneMiddleName,
    required this.beneLastName,
    required this.beneEmail,
    required this.beneDateOfBirth,
    required this.beneMobileNumber,
    required this.beneAddress,
    required this.beneCity,
    required this.benificiaryCountry,
    required this.paymentType,
    required this.isactive,
    required this.remitterId,
    required this.partnerId,
    required this.beneCardNumber,
    this.beneBankDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) =>
      BeneficiaryData(
        beneId: json["bene_id"],
        beneFirstName: json["bene_first_name"],
        beneMiddleName: json["bene_middle_name"],
        beneLastName: json["bene_last_name"],
        beneEmail: json["bene_email"],
        beneDateOfBirth: json["bene_date_of_birth"],
        beneMobileNumber: json["bene_mobile_number"],
        beneAddress: json["bene_address"],
        beneCity: json["bene_city"],
        benificiaryCountry: json["benificiary_country"],
        paymentType: json["payment_type"] ?? 0,
        isactive: json["isactive"],
        remitterId: json["remitter_id"],
        partnerId: json["partner_id"],
        beneCardNumber: json["bene_card_number"],
        beneBankDetails: json["bene_bank_details"] == null
            ? null
            : BeneBankDetails.fromJson(json["bene_bank_details"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "bene_id": beneId,
        "bene_first_name": beneFirstName,
        "bene_middle_name": beneMiddleName,
        "bene_last_name": beneLastName,
        "bene_email": beneEmail,
        "bene_date_of_birth": beneDateOfBirth,
        "bene_mobile_number": beneMobileNumber,
        "bene_address": beneAddress,
        "bene_city": beneCity,
        "benificiary_country": benificiaryCountry,
        "payment_type": paymentType,
        "isactive": isactive,
        "remitter_id": remitterId,
        "partner_id": partnerId,
        "bene_card_number": beneCardNumber,
        "bene_bank_details": beneBankDetails,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class BeneBankDetails {
  String? bank;
  String? bankIfscCode;

  BeneBankDetails({
    this.bank,
    this.bankIfscCode,
  });

  factory BeneBankDetails.fromJson(Map<String, dynamic> json) =>
      BeneBankDetails(
        bank: json["bank"],
        bankIfscCode: json["bank_ifsc_code"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "bank_ifsc_code": bankIfscCode,
      };
}

class TransactionData {
  int id;
  String username;
  int remitterId;
  int partnerId;
  String paymentTypePi;
  int beneficiaryId;
  String sourceCountry;
  String destinationCountry;
  String sourceCurrency;
  String destinationCurrency;
  String amountType;
  String sourceAmount;
  String destinationAmount;
  String payInTransId;
  String payOutTransId;
  String purpose;
  String sourceOfIncome;
  int accountItemNumber;
  String transferTypePo;
  bool complianceNeeded;
  bool complianceChecked;
  bool extComplianceNeeded;
  bool extComplianceChecked;
  String paymentToken;
  String remitterWalletCurrency;
  int serviceLevel;
  String promotionCode;
  bool smsConfirmation;
  bool smsNotification;
  String smsMobile;
  bool smsBenefConfirmation;
  String smsBenefMobile;
  String utilityBillInvoice;
  String utilityBillDescription;
  String commentsOnBeneficiary;
  String transSessionId;
  String transactionStatus;
  int smsBeneConfirmationOtp;
  int smsRemitterConfirmationOtp;
  DateTime createdAt;
  DateTime updatedAt;

  TransactionData({
    required this.id,
    required this.username,
    required this.remitterId,
    required this.partnerId,
    required this.paymentTypePi,
    required this.beneficiaryId,
    required this.sourceCountry,
    required this.destinationCountry,
    required this.sourceCurrency,
    required this.destinationCurrency,
    required this.amountType,
    required this.sourceAmount,
    required this.destinationAmount,
    required this.payInTransId,
    required this.payOutTransId,
    required this.purpose,
    required this.sourceOfIncome,
    required this.accountItemNumber,
    required this.transferTypePo,
    required this.complianceNeeded,
    required this.complianceChecked,
    required this.extComplianceNeeded,
    required this.extComplianceChecked,
    required this.paymentToken,
    required this.remitterWalletCurrency,
    required this.serviceLevel,
    required this.promotionCode,
    required this.smsConfirmation,
    required this.smsNotification,
    required this.smsMobile,
    required this.smsBenefConfirmation,
    required this.smsBenefMobile,
    required this.utilityBillInvoice,
    required this.utilityBillDescription,
    required this.commentsOnBeneficiary,
    required this.transSessionId,
    required this.transactionStatus,
    required this.smsBeneConfirmationOtp,
    required this.smsRemitterConfirmationOtp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        id: json["id"],
        username: json["username"],
        remitterId: json["remitter_id"],
        partnerId: json["partner_id"],
        paymentTypePi: json["payment_type_pi"],
        beneficiaryId: json["beneficiary_id"],
        sourceCountry: json["source_country"],
        destinationCountry: json["destination_country"],
        sourceCurrency: json["source_currency"],
        destinationCurrency: json["destination_currency"],
        amountType: json["amount_type"],
        sourceAmount: json["source_amount"],
        destinationAmount: json["destination_amount"],
        payInTransId: json["pay_in_trans_id"],
        payOutTransId: json["pay_out_trans_id"],
        purpose: json["purpose"],
        sourceOfIncome: json["source_of_income"],
        accountItemNumber: json["account_item_number"],
        transferTypePo: json["transfer_type_po"],
        complianceNeeded: json["compliance_needed"],
        complianceChecked: json["compliance_checked"],
        extComplianceNeeded: json["ext_compliance_needed"],
        extComplianceChecked: json["ext_compliance_checked"],
        paymentToken: json["payment_token"],
        remitterWalletCurrency: json["remitter_wallet_currency"],
        serviceLevel: json["service_level"],
        promotionCode: json["promotion_code"],
        smsConfirmation: json["sms_confirmation"],
        smsNotification: json["sms_notification"],
        smsMobile: json["sms_mobile"],
        smsBenefConfirmation: json["sms_benef_confirmation"],
        smsBenefMobile: json["sms_benef_mobile"],
        utilityBillInvoice: json["utility_bill_invoice"],
        utilityBillDescription: json["utility_bill_description"],
        commentsOnBeneficiary: json["comments_on_beneficiary"],
        transSessionId: json["trans_session_id"],
        transactionStatus: json["transaction_status"],
        smsBeneConfirmationOtp: json["sms_bene_confirmation_otp"],
        smsRemitterConfirmationOtp: json["sms_remitter_confirmation_otp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "remitter_id": remitterId,
        "partner_id": partnerId,
        "payment_type_pi": paymentTypePi,
        "beneficiary_id": beneficiaryId,
        "source_country": sourceCountry,
        "destination_country": destinationCountry,
        "source_currency": sourceCurrency,
        "destination_currency": destinationCurrency,
        "amount_type": amountType,
        "source_amount": sourceAmount,
        "destination_amount": destinationAmount,
        "pay_in_trans_id": payInTransId,
        "pay_out_trans_id": payOutTransId,
        "purpose": purpose,
        "source_of_income": sourceOfIncome,
        "account_item_number": accountItemNumber,
        "transfer_type_po": transferTypePo,
        "compliance_needed": complianceNeeded,
        "compliance_checked": complianceChecked,
        "ext_compliance_needed": extComplianceNeeded,
        "ext_compliance_checked": extComplianceChecked,
        "payment_token": paymentToken,
        "remitter_wallet_currency": remitterWalletCurrency,
        "service_level": serviceLevel,
        "promotion_code": promotionCode,
        "sms_confirmation": smsConfirmation,
        "sms_notification": smsNotification,
        "sms_mobile": smsMobile,
        "sms_benef_confirmation": smsBenefConfirmation,
        "sms_benef_mobile": smsBenefMobile,
        "utility_bill_invoice": utilityBillInvoice,
        "utility_bill_description": utilityBillDescription,
        "comments_on_beneficiary": commentsOnBeneficiary,
        "trans_session_id": transSessionId,
        "transaction_status": transactionStatus,
        "sms_bene_confirmation_otp": smsBeneConfirmationOtp,
        "sms_remitter_confirmation_otp": smsRemitterConfirmationOtp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
