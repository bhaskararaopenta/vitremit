import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/common_widget/common_property.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();

  DashBoardProvider? _provider;
  String _countryCode = '';

  @override
  void initState() {
    _provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    AssetsConstant.logo,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Join out community',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black26),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: editTextProperty(
                          svg: AssetsConstant.userIcon,
                          hitText: 'Enter your name'),
                      style: const TextStyle(fontSize: 14),
                      controller: nameController,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Mobile Number*',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        return null;
                      },
                      decoration: editTextProperty(
                          svg: AssetsConstant.callIcon,
                          hitText: 'Enter your mobile number'),
                      style: const TextStyle(fontSize: 14),
                      controller: mobileController,
                      onChanged: (value) {},
                    ),
                  ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Sending From*',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      _provider?.whichTypeCountryMode =
                          Constants.showSourceCountry;
                      Navigator.pushNamed(
                        context,
                        RouterConstants.selectCountryRoute,
                        arguments: {
                          Constants.isComingFromSignUpPage: true
                        },
                      ).then((value) {
                        if (value != null) {
                          print(
                              '=========== ${_provider?.sourceCountryNameTitle}');
                          setState(() {
                            _countryCode = value as String;
                            countryController.text =
                            _provider!.sourceCountryNameTitle!;
                          });
                        }
                      });
                    },
                    child: SizedBox(
                      child: TextFormField(
                        enabled: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter country';
                          }
                          return null;
                        },
                        decoration: editTextProperty(
                            image: AssetsConstant.worldIcon,
                            hitText: 'Enter your country'),
                        style: const TextStyle(fontSize: 14),
                        controller: countryController,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Email*',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        // using regular expression
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      decoration: editTextProperty(
                          svg: AssetsConstant.emailIcon,
                          hitText: 'Enter your email'),
                      style: const TextStyle(fontSize: 14),
                      controller: emailController,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Password*',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: editTextProperty(
                          svg: AssetsConstant.lockIcon,
                          hitText: 'Enter your password'),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Consumer<LoginProvider>(builder: (_, provider, __) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onPressed: provider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final provider = Provider.of<LoginProvider>(
                                      context,
                                      listen: false,
                                    );
                                    try {
                                      final res = await provider.createUser(
                                        password: passwordController.text,
                                        email: emailController.text,
                                        mobileNo: mobileController.text,
                                        username: nameController.text,
                                        sourceCountry: _countryCode,
                                      );

                                      if (mounted && res.success) {
                                        Navigator.pushNamed(
                                          context,
                                          RouterConstants.otpRoute,
                                          arguments: {
                                            Constants.email:
                                                emailController.text,
                                            Constants.forgotPassword: false
                                          },
                                        );
                                      } else if (mounted && !res.success && res.error?.statusCode == 400) {
                                        Navigator.pushNamed(
                                          context,
                                          RouterConstants.otpRoute,
                                          arguments: {
                                            Constants.email:
                                                emailController.text,
                                            Constants.forgotPassword: false
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(res.error!.message),
                                        ));
                                      }
                                    } catch (e) {
                                      provider.setLoadingStatus(false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  }
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Create Account"));
                    }),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            ' Sign in',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
