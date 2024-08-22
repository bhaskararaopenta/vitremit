import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitremit/model/beneficiary_create_model.dart';
import 'package:vitremit/model/beneficiary_list_model.dart';
import 'package:vitremit/model/create_transaction_model.dart';
import 'package:vitremit/model/partner_rates_model.dart';
import 'package:vitremit/model/partner_source_country_model.dart';
import 'package:vitremit/model/partner_transaction_settings_model.dart';
import 'package:vitremit/model/payout_bank_model.dart';
import 'package:vitremit/model/profile_details_model.dart';
import 'package:vitremit/model/register_model.dart';
import 'package:vitremit/model/transaction_details_model.dart';
import 'package:vitremit/model/transaction_list_model.dart';
import 'package:vitremit/network/constants/constants.dart';
import 'package:vitremit/network/rest_client.dart';

class DashboardRepository {
  final _httpClient = RestClient();

  // instance of class singleton
  static final DashboardRepository _singleton = DashboardRepository._internal();

  DashboardRepository._internal();

  factory DashboardRepository() => _singleton;

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  Future<PartnerCountryModel> partnerSourceCountryAPI({bool? isComingFromSignUP = false}) async {
    String token = await getToken();
    final res = isComingFromSignUP! ?
    await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getSignUpSourceCountryList,
    )
    : await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerSourceCountryListAPI,
       headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerCountryModel.fromJson(res);
  }

  Future<PartnerCountryModel> partnerDestinationListAPI(
      ) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerDestinationListAPI,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerCountryModel.fromJson(res);
  }

  Future<PartnerTransactionSettingsModel> partnerTransactionSettingsAPI(
      ) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerTransactionSettingsAPI,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerTransactionSettingsModel.fromJson(res);
  }

  Future<BeneficiaryListModel> beneficiaryListAPI(
      {required int remitterId}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.beneficiaryListAPI,
      data: {
        'remitter_id': remitterId,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryListModel.fromJson(res);
  }

  Future<PartnerRatesModel> partnerRates(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPartnerRatesAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PartnerRatesModel.fromJson(res);
  }

  Future<BeneficiaryCreateModel> beneficiaryCreateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.beneficiaryCreateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryCreateModel.fromJson(res);
  }

  Future<BeneficiaryCreateModel> beneficiaryUpdateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.benificiaryUpdateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return BeneficiaryCreateModel.fromJson(res);
  }

  Future<CreateTransactionModel> transactionCreateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.transactionCreateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return CreateTransactionModel.fromJson(res);
  }

  Future<TransactionListModel> transactionListAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.listTransactionsAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return TransactionListModel.fromJson(res);
  }

  Map<String, dynamic> addRequireDataForCreating(
      {required Map<String, dynamic> data}) {
    Map<String, dynamic> map = {
      "benificiary_country": 104,
      "payment_type": 4,
      "date_of_birth": "01-01-2001",
      "address": "BHEL",
      "user_id": 1,
      "partner_id": 1,
      "card_number": "",
      "bank_account_number": "",
      "bank_account_type": "",
      "bank_account_name": "",
      "bank": "",
      "back_ifsc_code": "",
      "bank_branch_id": 0,
      "bank_city": "",
      "back_state": "",
      "bank_additional_details": "",
      "collection_point_id": "",
      "collection_point_name": "",
      "collection_point_code": "",
      "collection_point_proc_bank": "",
      "collection_point_address": "",
      "collection_point_city": "",
      "collection_point_state": "",
      "collection_point_tel": 0,
      "mobile_transfer_number": 0,
      "mobile_transfer_network": "",
      "mobile_transfer_network_id": 0,
      "mobile_transfer_network_credit_type_id": 0,
      "mobile_transfer_network_credit_type": "",
    };
    map.addAll(data);
    return map;
  }

  Future<PayoutBankModel> payoutsBanksAPI(
      {required String countryCode}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getPayoutsBanksAPI + countryCode,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    return PayoutBankModel.fromJson(res);
  }

  Future<RegisterModel> userDetailUpdateAPI(
      {required Map<String, dynamic> data}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.userDetailUpdateAPI,
      data: data,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return RegisterModel.fromJson(res);
  }

  Future<TransactionDetailsModel> transactionDetailsAPI(
      {required String transactionId}) async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.transactionDetails+'$transactionId',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return TransactionDetailsModel.fromJson(res);
  }

  Future<ProfileDetailsModel> getProfileDetails() async {
    String token = await getToken();
    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.getProfileDetails,
      data: {"data":"RemitterId"},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    return ProfileDetailsModel.fromJson(res);
  }
}
