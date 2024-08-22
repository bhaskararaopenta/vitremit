import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/common_widget/common_property.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    usernameController.text = 'suvrajyoti@it4yourbusiness.in';
    // usernameController.text = '00jitendrayaduvansh@gmail.com';
    // usernameController.text = 'soni.yogesh73@gmail.com';
   // usernameController.text = 'thiru.258@gmail.com';
    passwordController.text = 'Code@2023';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
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
                  height: 10,
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Login to Continue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black26),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Email/Phone*',
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
                        return 'Please enter username';
                      }
                      return null;
                    },
                    decoration: editTextProperty(
                        svg: AssetsConstant.userIcon,
                        hitText: 'Enter your email or phone'),
                    style: const TextStyle(fontSize: 14),
                    controller: usernameController,
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
                        svg: AssetsConstant.lockIcon, hitText: 'Password'),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouterConstants.forgotPasswordRoute);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.amber),
                        )),
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                  final provider = Provider.of<LoginProvider>(
                                    context,
                                    listen: false,
                                  );
                                  final res = await provider.loginAPI(
                                    password: passwordController.text,
                                    email: usernameController.text,
                                  );

                                  if (mounted && res.success) {
                                    if(res.userDetails?.kycStatus.toUpperCase() != 'KYC-OK'
                                        && res.userDetails?.amlStatus.toUpperCase() != 'AML-OK'){

                                      Fluttertoast.showToast(msg: 'Go and Complete their profile.');
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(const SnackBar(
                                      //   content: Text('Go and Complete their profile.'),
                                      // ));
                                    }
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                        RouterConstants.dashboardRoute,
                                            (Route<dynamic> route) => false);
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
                            : const Text("Log In"));
                  }),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New User?',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.signupRoute);
                        },
                        child: const Text(
                          ' Register here',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
