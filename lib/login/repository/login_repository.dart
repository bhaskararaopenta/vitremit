import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitremit/model/profile_details_model.dart';
import 'package:vitremit/model/register_model.dart';
import 'package:vitremit/network/constants/constants.dart';
import 'package:vitremit/network/rest_client.dart';

class LoginRepository {
  final _httpClient = RestClient();

  // instance of class singleton
  static final LoginRepository _singleton = LoginRepository._internal();

  LoginRepository._internal();

  factory LoginRepository() => _singleton;

  Future<void> newPasswordAPI({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final res = await _httpClient.post(
      ApiConstants.baseUrl + ApiConstants.newPasswordAPI,
      data: {
        'email': email,
        'new_password': newPassword,
        'confirm_password': confirmPassword
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> resetPasswordAPI({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.resetPasswordAPI, data: {
      'email': email,
      'new_password': newPassword,
      'confirm_password': confirmPassword
    });
  }

  Future<RegisterModel> forgotPasswordAPI({
    required String email,
  }) async {
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.forgotPasswordAPI, data: {
      'email': email,
    });
    return RegisterModel.fromJson(res);
  }

  Future<RegisterModel> userRegisterAPI({
    required String password,
    required String username,
    required String email,
    required String mobileNo,
    required String sourceCountry,
  }) async {
    var name = username.split(' ');
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.registerAPI, data: {
      'source_country': sourceCountry,
      //'user_name': username,
      //'partner_id': 1,
      'email': email,
      //'first_name': name[0] ?? '',
      //'last_name': name[1] ?? '',
      // 'date_of_birth': '01/12/2008',
      // 'mobile_code': '+91',
      // 'mobile_number': int.parse(mobileNo),
      'password': password,
    });

    print('=============== res $res');
    return RegisterModel.fromJson(res);
  }

  Future<RegisterModel> userLoginAPI({
    required String password,
    required String email,
  }) async {
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.loginAPI, data: {
      'email': email,
      'password': password,
    });

    return RegisterModel.fromJson(res);
  }

  Future<RegisterModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.verifyCodeAPI, data: {
      'email': email,
      'verification_code': otp,
    });
    return RegisterModel.fromJson(res);
  }

  Future<RegisterModel> forgotVerifyOTP({
    required String email,
    required String otp,
  }) async {
    final res = await _httpClient
        .post(ApiConstants.baseUrl + ApiConstants.forgotVerifyCodeAPI, data: {
      'email': email,
      'verification_code': otp,
    });

    return RegisterModel.fromJson(res);
  }

}
