import 'package:vitremit/login/add_new_card.dart';
import 'package:vitremit/login/add_new_recipient.dart';
import 'package:vitremit/login/dashboard.dart';
import 'package:vitremit/login/forgot_password_page.dart';
import 'package:vitremit/login/login_page.dart';
import 'package:vitremit/login/otp_page.dart';
import 'package:vitremit/login/payment_detail_page.dart';
import 'package:vitremit/login/payment_type_page.dart';
import 'package:vitremit/login/profile_page.dart';
import 'package:vitremit/login/recipient_details_page.dart';
import 'package:vitremit/login/rest_password_page.dart';
import 'package:vitremit/login/select_country_page.dart';
import 'package:vitremit/login/select_payment_mode_page.dart';
import 'package:vitremit/login/sending_money_page.dart';
import 'package:vitremit/login/signup_page.dart';
import 'package:vitremit/login/transaction_details_page.dart';
import 'package:vitremit/login/transactions_page.dart';
import 'package:vitremit/login/transfer_details_page.dart';
import 'package:vitremit/login/webview_pay_page.dart';
import 'package:vitremit/router/router.dart';
import 'package:flutter/material.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget body;
    switch (settings.name) {
      case RouterConstants.loginRoute:
        body = const LoginPage();
        break;
      case RouterConstants.signupRoute:
        body = const SignupPage();
        break;
      case RouterConstants.dashboardRoute:
        body = const DashboardPage();
        break;
      case RouterConstants.otpRoute:
        body = const OTPPage();
        break;
      case RouterConstants.addNewRecipientRoute:
        body = const AddNewRecipientPage();
        break;
      case RouterConstants.recipientDetailsRoute:
        body = const RecipientDetailsPage();
        break;
      case RouterConstants.paymentTypeRoute:
        body = const PaymentTypePage();
        break;
      case RouterConstants.selectCountryRoute:
        body = const SelectCountryPage();
        break;
      case RouterConstants.sendingMoneyRoute:
        body = const SendingMoneyPage();
        break;
      case RouterConstants.addNewCardsRoute:
        body = const AddNewCard();
        break;
      case RouterConstants.transitionRoute:
        body = const TransactionsPage();
        break;
      case RouterConstants.forgotPasswordRoute:
        body = const ForgotPasswordPage();
        break;
      case RouterConstants.restPasswordRoute:
        body = const RestPasswordPage();
        break;
      case RouterConstants.paymentModeRoute:
        body = const SelectPaymentModePage();
        break;
      case RouterConstants.profileRoute:
        body = const ProfilePage();
        break;
      case RouterConstants.transferDetailRoute:
        body = const TransferDetailsPage();
        break;
      case RouterConstants.paymentDetailRoute:
        body = const PaymentDetailPage();
        break;
      case RouterConstants.paymentHTMLRoute:
        body = const PaymentHTMLPage();
        break;
      case RouterConstants.transactionDetailsRoute:
        body = const TransactionDetailsPage();
        break;
      default:
        body = Container();
    }

    return MaterialPageRoute(builder: (context) => body, settings: settings);
  }
}
