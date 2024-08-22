class ApiConstants {
  static const String baseUrl =
      'https://xbp.uat.volant-ubicomms.com/vitpay/api/v1';

  static const String registerAPI = '/remitter/create';
  // static const String registerAPI = '/register';
  static const String loginAPI = '/login';
  static const String resetPasswordAPI = '/resetpassword';
  static const String forgotPasswordAPI = '/forgotpassword';
  static const String verifyCodeAPI = '/register/verifycode';
  static const String newPasswordAPI = '/forgotpassword/newpassword';
  static const String forgotVerifyCodeAPI = '/forgotpassword/verifycode';

  static const String beneficiaryCreateAPI = '/benificiary/create';
  static const String beneficiaryListAPI = '/benificiary/list';
  static const String getPartnerSourceCountryListAPI = '/getPartnersourcecountrylist';
  static const String getPartnerDestinationListAPI = '/getPartnerdestinationlist';
  static const String getPartnerTransactionSettingsAPI = '/getPartnerTransactionSettings';
  static const String getPartnerRatesAPI = '/getPartnerRates';
  static const String getPayoutsBanksAPI = '/payoutsBanks/';
  static const String transactionCreateAPI = '/transaction/create';
  static const String benificiaryUpdateAPI = '/benificiary/update';

  static const String userDetailUpdateAPI = '/remitter/verify';
  static const String listTransactionsAPI = '/ListTransactions';
  static const String transactionDetails = '/transaction/';
  static const String getSignUpSourceCountryList = '/getSignUpSourceCountryList';
  static const String getProfileDetails = '/GetRemitterList';

}
