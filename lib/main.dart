import 'package:provider/provider.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/main_router.dart';
import 'package:vitremit/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
      ],
      child: MaterialApp(
        title: 'Vitremit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: MainRouter.generateRoute,
        initialRoute: RouterConstants.loginRoute,
      ),
    );
  }
}
