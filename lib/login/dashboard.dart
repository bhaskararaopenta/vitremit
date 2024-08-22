import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/login/home_page.dart';
import 'package:vitremit/login/payment_type_page.dart';
import 'package:vitremit/login/sending_money_page.dart';
import 'package:vitremit/login/transactions_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int i = 0;

  Widget currentScreen() {
    switch (i) {
      case 0:
        {
          return const HomePage();
        }
      case 1:
        {
          return const TransactionsPage();
        }
      case 2:
        {
          return const HomePage();
        }
      case 3:
        {
          return const SendingMoneyPage();
        }
      case 4:
        {
          return const TransactionsPage();
        }
      default:
        return const HomePage();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
        ModalRoute
            .of(context)!
            .settings
            .arguments as Map<String, dynamic>;
        i = arguments[Constants.dashboardPageOpen] as int;
        final CurvedNavigationBarState? navBarState =
            _bottomNavigationKey.currentState;
        navBarState?.setPage(i);
        setState(() {
          i;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: currentScreen(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        buttonBackgroundColor: const Color(0xffEFBC22),
        items: [
          CurvedNavigationBarItem(
            labelStyle: TextStyle(
              color: i == 0 ? const Color(0xffEFBC22) : Colors.white,
            ),
            child: SvgPicture.asset(
              AssetsConstant.navHomeIcon,
              color: i == 0 ? const Color(0xffEFBC22) : Colors.white,
            ),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AssetsConstant.navTaskIcon,
              color: i == 1 ? const Color(0xffEFBC22) : Colors.white,
            ),
            label: 'Transfer',
            labelStyle: TextStyle(
              color: i == 1 ? const Color(0xffEFBC22) : Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AssetsConstant.navSendIcon,
              height: 40,
            ),
            label: 'Send',
            labelStyle: TextStyle(
              color: i == 2 ? const Color(0xffEFBC22) : Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AssetsConstant.navProfileIcon,
              color: i == 3 ? const Color(0xffEFBC22) : Colors.white,
            ),
            label: 'Receiver',
            labelStyle: TextStyle(
              color: i == 3 ? const Color(0xffEFBC22) : Colors.white,
            ),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AssetsConstant.navMessageIcon,
              color: i == 4 ? const Color(0xffEFBC22) : Colors.white,
            ),
            label: 'Help',
            labelStyle: TextStyle(
              color: i == 4 ? const Color(0xffEFBC22) : Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          // Handle button tap
          setState(() {
            i = index;
          });
        },
      ),
    );
  }
}
