import 'package:flutter/material.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/dashboard/repository/dashboard_repository.dart';
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

class DashBoardProvider with ChangeNotifier {
  final _dashboardRepository = DashboardRepository();
  final sendAmountController = TextEditingController();
  final receiveAmountController = TextEditingController();

  var _isLoading = false;
  String _selectCountryCode = '';
  PartnerCountryModel? _countryModel;
  PartnerCountryModel? _countryDestinationList;
  PartnerTransactionSettingsModel? _partnerTransactionSettingsModel;
  BeneficiaryListModel? _beneficiaryListModel;
  PartnerRatesModel? _partnerRatesModel;
  PayoutBankModel? _payoutBankModel;
  String? _sourceCountryName;
  int _serviceLevel = 1;

  TransactionListModel? _transactionList;
  TransactionDetailsModel? _transactionDetailsModel;

  String _sourceCountry = 'GBP';
  String _sourceCurrency = 'GBP';
  String _destinationCountry = 'RWF';
  String _destinationCurrency = 'RWF';
  String _selectPaymentMode = 'Wallet';
  int _selectPaymentCode = 1;
  String _selectPaymentType = '';
  String _whichTypeCountryMode = '';

  //For Payment Convert
  String _platformFees = '0.0';
  String _totalFees = '0.0';
  String _convertRate = '0.0';
  String _rate = '0.0';
  String _receiveAmount = '0.0';
  String _shouldArrive = '';


  ProfileDetailsModel? _profileDetailsModel;
  ProfileDetailsModel? get profileDetailsModel => _profileDetailsModel;

  int get serviceLevel => _serviceLevel;

  PayoutBankModel? get payoutBankModel => _payoutBankModel;

  int get selectPaymentCode => _selectPaymentCode;

  TransactionDetailsModel? get transactionDetailsModel =>
      _transactionDetailsModel;

  String get sourceCurrency => _sourceCurrency;

  set transactionDetailsModel(TransactionDetailsModel? value) {
    _transactionDetailsModel = value;
  }

  set sourceCurrency(String value) {
    _sourceCurrency = value;
  }

  set selectPaymentCode(int value) {
    _selectPaymentCode = value;
  }

  TransactionListModel? get transactionList => _transactionList;

  String? get sourceCountryNameTitle => _sourceCountryName;

  set sourceCountryName(String value) {
    _sourceCountryName = value;
  }

  String get platformFees => _platformFees;

  PartnerRatesModel? get partnerRatesModel => _partnerRatesModel;

  BeneficiaryListModel? get beneficiaryListModel => _beneficiaryListModel;

  String get whichTypeCountryMode => _whichTypeCountryMode;

  set whichTypeCountryMode(String value) {
    _whichTypeCountryMode = value;
    notifyListeners();
  }

  String get sourceCountry => _sourceCountry;

  set sourceCountry(String value) {
    _sourceCountry = value;
    notifyListeners();
  }

  String get destinationCountry => _destinationCountry;

  set destinationCountry(String value) {
    _destinationCountry = value;
    notifyListeners();
  }

  String get selectPaymentMode => _selectPaymentMode;

  set selectPaymentMode(String value) {
    _selectPaymentMode = value;
    print('========== $value');
    notifyListeners();
  }

  String get selectPaymentType => _selectPaymentType;

  set selectPaymentType(String value) {
    _selectPaymentType = value;
    notifyListeners();
  }

  get isLoading => _isLoading;

  String get selectCountryCode => _selectCountryCode;

  PartnerCountryModel? get countryModel => _countryModel;

  PartnerCountryModel? get countryDestinationList => _countryDestinationList;

  PartnerTransactionSettingsModel? get partnerTransactionSettingsModel =>
      _partnerTransactionSettingsModel;

  void selectCountryCodeByUser(String countryCode) {
    _selectCountryCode = countryCode;
    notifyListeners();
  }

  void setLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> getCountryList({bool? isComingFromSignUP = false}) async {
    setLoadingStatus(true);
    try {
      _countryModel = await _dashboardRepository.partnerSourceCountryAPI(
          isComingFromSignUP: isComingFromSignUP);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getCountryDestinationList() async {
    setLoadingStatus(true);
    try {
      _countryDestinationList =
          await _dashboardRepository.partnerDestinationListAPI();
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getPartnerTransactionSettings() async {
    setLoadingStatus(true);
    try {
      _partnerTransactionSettingsModel =
          await _dashboardRepository.partnerTransactionSettingsAPI();
      _serviceLevel = _partnerTransactionSettingsModel
              ?.response.serviceLevelDeliverySpeedCodes[0].code ??
          1;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> beneficiaryCreate({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      await _dashboardRepository.beneficiaryCreateAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> beneficiaryUpdate({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      await _dashboardRepository.beneficiaryUpdateAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getPartnerRates({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      _partnerRatesModel = await _dashboardRepository.partnerRates(data: data);
      _totalFees = _partnerRatesModel!.response.totalFees;
      _convertRate = _partnerRatesModel!.response.conversionRate;
      _rate = _partnerRatesModel!.response.amountToConvert;
      _receiveAmount = _partnerRatesModel!.response.receiveAmount;
      _shouldArrive = _partnerRatesModel!.response.shouldArrive;
      _platformFees = _partnerRatesModel!.response.platformFee;
      if (data['action'] != 'source') {
        sendAmountController.text =
            double.parse(_receiveAmount).toStringAsFixed(2);
        receiveAmountController.text = data['amount'].toString();
      } else {
        sendAmountController.text = data['amount'].toString();
        receiveAmountController.text =
            double.parse(_receiveAmount).toStringAsFixed(2);
      }
      setLoadingStatus(false);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getBeneficiaryList({required int remitterId}) async {
    setLoadingStatus(true);
    try {
      _beneficiaryListModel =
          await _dashboardRepository.beneficiaryListAPI(remitterId: remitterId);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getPayoutsBanksList({required String countryCode}) async {
    try {
      setLoadingStatus(true);
      _payoutBankModel = await _dashboardRepository.payoutsBanksAPI(
        countryCode: countryCode,
      );
      setLoadingStatus(false);
    } catch (e) {
      _payoutBankModel = null;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<CreateTransactionModel> transactionCreateAPI(
      {required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.transactionCreateAPI(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> transactionListAPI({required Map<String, dynamic> data}) async {
    setLoadingStatus(true);
    try {
      _transactionList =
          await _dashboardRepository.transactionListAPI(data: data);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> transactionDetailsAPI({required String transactionId}) async {
    setLoadingStatus(true);
    try {
      _transactionDetailsModel = await _dashboardRepository
          .transactionDetailsAPI(transactionId: transactionId);
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<RegisterModel> userDetailUpdateAPI({
    required Map<String, dynamic> data,
  }) async {
    setLoadingStatus(true);
    try {
      final res = await _dashboardRepository.userDetailUpdateAPI(data: data);
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }

  Future<void> getProfileDetails() async {
    setLoadingStatus(true);
    try {
      _profileDetailsModel = await _dashboardRepository.getProfileDetails();
    }finally{
      setLoadingStatus(false);
    }
  }

  String getCountryFlag(String countryCode) {
    String imagePath = '';
    if (countryCode == 'GBP') {
      imagePath = AssetsConstant.gbpFlagIcon;
    } else if (countryCode == 'RWF') {
      imagePath = AssetsConstant.rwfFlagIcon;
    } else if (countryCode == 'TZS') {
      imagePath = AssetsConstant.tzsFlagIcon;
    } else if (countryCode == 'UGX') {
      imagePath = AssetsConstant.ugxFlagIcon;
    } else if (countryCode == 'ZMW') {
      imagePath = AssetsConstant.zmwFlagIcon;
    } else if (countryCode == 'ZWL') {
      imagePath = AssetsConstant.zwlFlagIcon;
    } else if (countryCode == 'ZK') {
      imagePath = AssetsConstant.zmwFlagIcon;
    }
    return imagePath;
  }

  //For Payment Convert
  String get totalFees => _totalFees;

  String get convertRate => _convertRate;

  String get rate => _rate;

  String get receiveAmount => _receiveAmount;

  String get shouldArrive => _shouldArrive;

  String get destinationCurrency => _destinationCurrency;

  set destinationCurrency(String value) {
    _destinationCurrency = value;
  }
}
