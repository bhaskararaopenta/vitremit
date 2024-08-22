// To parse this JSON data, do
//
//     final partnerTransactionSettingsModel = partnerTransactionSettingsModelFromJson(jsonString);

import 'dart:convert';

PartnerTransactionSettingsModel partnerTransactionSettingsModelFromJson(String str) => PartnerTransactionSettingsModel.fromJson(json.decode(str));

String partnerTransactionSettingsModelToJson(PartnerTransactionSettingsModel data) => json.encode(data.toJson());

class PartnerTransactionSettingsModel {
  bool success;
  String message;
  TransactionSource response;

  PartnerTransactionSettingsModel({
    required this.success,
    required this.message,
    required this.response,
  });

  factory PartnerTransactionSettingsModel.fromJson(Map<String, dynamic> json) => PartnerTransactionSettingsModel(
    success: json["success"],
    message: json["message"],
    response: TransactionSource.fromJson(json["response"][0]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": response.toJson(),
  };

  List<PaymentMethodCode> getPaymentMethodList(){
    return response.paymentMethodCodes;
  }
}

class TransactionSource {
  int id;
  int partnerId;
  List<PaymentMethodCode> paymentMethodCodes;
  List<Code> remittancePurposeCodes;
  List<Code> sourceOfIncomeCodes;
  List<Code> serviceLevelDeliverySpeedCodes;
  List<TransactionStatus> transactionStatuses;
  List<Type> transactionPaymentInstructionTypes;
  List<Type> remitterCreditTypes;
  List<PaymentMethodCode> transferTypes;

  TransactionSource({
    required this.id,
    required this.partnerId,
    required this.paymentMethodCodes,
    required this.remittancePurposeCodes,
    required this.sourceOfIncomeCodes,
    required this.serviceLevelDeliverySpeedCodes,
    required this.transactionStatuses,
    required this.transactionPaymentInstructionTypes,
    required this.remitterCreditTypes,
    required this.transferTypes,
  });

  factory TransactionSource.fromJson(Map<String, dynamic> json) => TransactionSource(
    id: json["id"],
    partnerId: json["partner_id"],
    paymentMethodCodes: List<PaymentMethodCode>.from(json["payment_method_codes"].map((x) => PaymentMethodCode.fromJson(x))),
    remittancePurposeCodes: List<Code>.from(json["remittance_purpose_codes"].map((x) => Code.fromJson(x))),
    sourceOfIncomeCodes: List<Code>.from(json["source_of_income_codes"].map((x) => Code.fromJson(x))),
    serviceLevelDeliverySpeedCodes: List<Code>.from(json["service_level_delivery_speed_codes"].map((x) => Code.fromJson(x))),
    transactionStatuses: List<TransactionStatus>.from(json["transaction_statuses"].map((x) => TransactionStatus.fromJson(x))),
    transactionPaymentInstructionTypes: List<Type>.from(json["transaction_payment_instruction_types"].map((x) => Type.fromJson(x))),
    remitterCreditTypes: List<Type>.from(json["remitter_credit_types"].map((x) => Type.fromJson(x))),
    transferTypes: List<PaymentMethodCode>.from(json["transfer_types"].map((x) => PaymentMethodCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "partner_id": partnerId,
    "payment_method_codes": List<dynamic>.from(paymentMethodCodes.map((x) => x.toJson())),
    "remittance_purpose_codes": List<dynamic>.from(remittancePurposeCodes.map((x) => x.toJson())),
    "source_of_income_codes": List<dynamic>.from(sourceOfIncomeCodes.map((x) => x.toJson())),
    "service_level_delivery_speed_codes": List<dynamic>.from(serviceLevelDeliverySpeedCodes.map((x) => x.toJson())),
    "transaction_statuses": List<dynamic>.from(transactionStatuses.map((x) => x.toJson())),
    "transaction_payment_instruction_types": List<dynamic>.from(transactionPaymentInstructionTypes.map((x) => x.toJson())),
    "remitter_credit_types": List<dynamic>.from(remitterCreditTypes.map((x) => x.toJson())),
    "transfer_types": List<dynamic>.from(transferTypes.map((x) => x.toJson())),
  };
}

class PaymentMethodCode {
  int code;
  String name;
  String? imgPath;
  String description;
  String? value;

  PaymentMethodCode({
    required this.code,
    required this.name,
    this.imgPath,
    required this.description,
    this.value,
  });

  factory PaymentMethodCode.fromJson(Map<String, dynamic> json) => PaymentMethodCode(
    code: json["code"],
    name: json["name"],
    imgPath: json["imgPath"],
    description: json["description"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "imgPath": imgPath,
    "description": description,
    "value": value,
  };
}

class Code {
  int code;
  String? description;
  String? name;

  Code({
    required this.code,
    required this.description,
    required this.name,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
    code: json["code"],
    description: json["description"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "name": name,
  };
}

class Type {
  String type;
  String description;

  Type({
    required this.type,
    required this.description,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    type: json["type"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "description": description,
  };
}

class TransactionStatus {
  String status;
  String description;

  TransactionStatus({
    required this.status,
    required this.description,
  });

  factory TransactionStatus.fromJson(Map<String, dynamic> json) => TransactionStatus(
    status: json["status"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "description": description,
  };
}
