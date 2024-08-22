import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitremit/login/repository/login_repository.dart';
import 'package:vitremit/model/profile_details_model.dart';
import 'package:vitremit/model/register_model.dart';

class LoginProvider with ChangeNotifier {
  final _loginRepository = LoginRepository();

  RegisterModel? _userInfo; 
  var _isLoading = false;


  get isLoading => _isLoading;

  RegisterModel? get userInfo => _userInfo;



  void setLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> _saveIntoLocalPref(String? token) async {
    if(token == null){
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? '');

  }
  
  Future<RegisterModel> createUser({
    required String password,
    required String username,
    required String email,
    required String mobileNo,
    required String sourceCountry,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.userRegisterAPI(
      password: password,
      username: username,
      email: email,
      mobileNo: mobileNo,
      sourceCountry: sourceCountry,
    );
    try {
      _userInfo = res;
      _saveIntoLocalPref(res.token);
    }catch(e){

    }
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.verifyOTP(email: email, otp: otp);
    _userInfo = res;
    _saveIntoLocalPref(res.token);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> loginAPI({
    required String email,
    required String password,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.userLoginAPI(
        email: email, password: password);
    _userInfo = res;
    _saveIntoLocalPref(res.token);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> forgotPasswordAPI({
    required String email,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.forgotPasswordAPI(
      email: email,
    );
    _saveIntoLocalPref(res.token);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> forgotVerifyOTPAPI({
    required String email,
    required String otp,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.forgotVerifyOTP(email: email, otp: otp);
    _userInfo = res;
    _saveIntoLocalPref(res.token);
    setLoadingStatus(false);
    return res;
  }

  Future<void> resetPasswordAPI({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.newPasswordAPI(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    setLoadingStatus(false);
    return res;
  }
}
