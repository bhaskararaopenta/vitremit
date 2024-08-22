import 'package:provider/provider.dart';
import 'package:vitremit/common_widget/common_property.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();

  late FocusNode myFocusNode1;
  late FocusNode myFocusNode2;
  late FocusNode myFocusNode3;
  late FocusNode myFocusNode4;

  @override
  void initState() {
    myFocusNode1 = FocusNode();
    myFocusNode2 = FocusNode();
    myFocusNode3 = FocusNode();
    myFocusNode4 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode1.dispose();
    myFocusNode2.dispose();
    myFocusNode3.dispose();
    myFocusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = arguments[Constants.email] as String;
    final isComingFromForgotPass = arguments[Constants.forgotPassword] as bool;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Enter 4 digit code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 250,
                child: Text(
                  'One time password send to your phone number +91*******6789',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black26),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                AssetsConstant.otpUserIcon,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      focusNode: myFocusNode1,
                      controller: otp1Controller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      maxLines: 1,
                      decoration: editTextProperty(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      onChanged: (value) {
                        otp1Controller.text = value;
                        if(value.isNotEmpty){
                          myFocusNode2.requestFocus();
                        }else{
                          myFocusNode1.requestFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      focusNode: myFocusNode2,
                      controller: otp2Controller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      maxLines: 1,
                      decoration: editTextProperty(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      onChanged: (value) {
                        otp2Controller.text = value;
                        if(value.isNotEmpty){
                          myFocusNode3.requestFocus();
                        }else{
                          myFocusNode1.requestFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      focusNode: myFocusNode3,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: otp3Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      maxLines: 1,
                      decoration: editTextProperty(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      onChanged: (value) {
                        otp3Controller.text = value;
                        if(value.isNotEmpty){
                          myFocusNode4.requestFocus();
                        }else{
                          myFocusNode2.requestFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      focusNode: myFocusNode4,
                      controller: otp4Controller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      maxLines: 1,
                      decoration: editTextProperty(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                      onChanged: (value) {
                        otp4Controller.text = value;
                        if(value.isNotEmpty){
                          myFocusNode4.requestFocus();
                        }else{
                          myFocusNode3.requestFocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Don\'t Receive Code ?',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'Resend Code',
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Consumer<LoginProvider>(
                  builder: (_, provider, __) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: provider.isLoading
                            ? null
                            :() async {
                          String otp = otp1Controller.text +
                              otp2Controller.text +
                              otp3Controller.text +
                              otp4Controller.text;

                          if (otp.length != 4) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Invalid OTP'),
                            ));
                            return;
                          }

                          final provider = Provider.of<LoginProvider>(
                            context,
                            listen: false,
                          );
                          try {
                            final res = isComingFromForgotPass
                                ? await provider.forgotVerifyOTPAPI(
                                    email: email, otp: otp)
                                : await provider.verifyOTP(email: email, otp: otp);

                            if (mounted && res.success) {
                              if(isComingFromForgotPass){
                                Navigator.pushNamed(
                                    context,
                                        RouterConstants.restPasswordRoute,
                                    arguments: {
                                      Constants.email:
                                      email,
                                      Constants.forgotPassword: true
                                    });
                              } else {
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil(RouterConstants.loginRoute, (Route<dynamic> route) => false);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(res.error?.message ?? ''),
                              ));
                            }
                          } catch (e) {
                            provider.setLoadingStatus(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        },
                        child: provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Continue"));
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
