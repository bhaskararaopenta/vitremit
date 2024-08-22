import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _debounce;
  String? userName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      final loginProvider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      provider.sendAmountController.text = '100';
      provider.receiveAmountController.text = '0';
      await provider.getCountryList();
      await provider.getCountryDestinationList();
      await provider.getPartnerTransactionSettings();

      _callPartnerRates(amount: '100');
    });
    super.initState();
  }

  _onSearchChanged({required String query, String? action = 'source'}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query.isEmpty) return;
    _debounce = Timer(const Duration(milliseconds: 500), () {
      query = query.endsWith('.') ? query.replaceAll('.', '') : query;
      _callPartnerRates(amount: query, action: action);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _callPartnerRates({required String amount, String? action = 'source', }) async {
    try {
      final loginProvider = Provider.of<LoginProvider>(
        context,
        listen: false,
      );
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );

      Map<String, dynamic> data = {
        'partner_id': loginProvider.userInfo!.userDetails!.partnerId,
        'source_currency': provider.sourceCountry,
        'destination_currency': provider.destinationCountry,
        'transfer_type_po': provider.selectPaymentMode.toLowerCase(),
        'amount': double.parse(amount),
        'service_level': provider.serviceLevel,
        'action': action,
      };

      provider.getPartnerRates(data: data);
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ),);
      }
    }
  }

  void showMemberMenu(BuildContext context) async {
    double s = MediaQuery.of(context).size.width*95;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(s, 50, 0, 50),
      items: const[
        PopupMenuItem(
          value: 1,
          child: Text('Profile',),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Logout',),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null){
        if(value == 1){
          Navigator.pushNamed(context, RouterConstants.profileRoute);
        }else {
          Navigator.popAndPushNamed(context, RouterConstants.loginRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Hi ${loginProvider.userInfo?.userDetails?.firstName}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 18),
                        ),
                      ),

                      IconButton(onPressed: (){
                        showMemberMenu(context);
                      }, icon: const Icon(FontAwesomeIcons.user))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Welcome,VitPay',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 72,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black12),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                            topStart: Radius.circular(12),
                                            bottomStart: Radius.circular(12)),
                                    color:
                                        const Color.fromRGBO(246, 247, 249, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'You Send',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            provider.sendAmountController,
                                        onChanged: (q){
                                          _onSearchChanged(query: q);
                                        },
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 72,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12),
                                  borderRadius:
                                      const BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(12),
                                          bottomEnd: Radius.circular(12)),
                                  color:
                                      const Color.fromRGBO(234, 233, 237, 1)),
                              child: SizedBox(
                                width: 100,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.whichTypeCountryMode =
                                        Constants.showSourceCountry;
                                    Navigator.pushNamed(
                                      context,
                                      RouterConstants.selectCountryRoute,
                                    ).then((value) {
                                      if (value != null) {
                                        provider.sourceCountry =
                                            value as String;
                                      }
                                      _callPartnerRates(action: '', amount: provider.sendAmountController.text);
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        provider.getCountryFlag(provider.sourceCountry),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        provider.sourceCountry,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Icon(
                                          Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.remove_circle,
                              color: Colors.grey[350],
                              size: 30,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('${provider.totalFees}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),
                            const Expanded(
                              child: Text('Our Fees',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.pause_circle_sharp,
                              color: Colors.grey[350],
                              size: 30,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(double.parse(provider.rate).toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                )),
                            const Expanded(
                              child: Text('Total Amount we\'ll convert',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.circle_sharp,
                                  color: Colors.grey[350],
                                  size: 30,
                                ),
                               const Icon(
                                  Icons.percent,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                                '${provider.destinationCountry}  ${NumberFormat.decimalPattern().format(double.parse(provider.convertRate))}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),
                            Expanded(
                              child: Text('Rate',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600])),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 72,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black12),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                            topStart: Radius.circular(12),
                                            bottomStart: Radius.circular(12)),
                                    color:
                                        const Color.fromRGBO(246, 247, 249, 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'They receive',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller:
                                        provider.receiveAmountController,
                                        onChanged: (q){
                                          _onSearchChanged(query: q, action: 'destination');
                                        },
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // Text(
                                    //   ' ${NumberFormat.decimalPattern().format(double.parse(provider.receiveAmount))}',
                                    //   style: const TextStyle(
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.w700),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 72,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black12),
                                  borderRadius:
                                      const BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(12),
                                          bottomEnd: Radius.circular(12)),
                                  color:
                                      const Color.fromRGBO(234, 233, 237, 1)),
                              child: SizedBox(
                                width: 100,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.whichTypeCountryMode =
                                        Constants.showDestinationCountry;
                                    Navigator.pushNamed(
                                      context,
                                      RouterConstants.selectCountryRoute,
                                    ).then((value) {
                                      if (value != null) {
                                        provider.destinationCountry =
                                            value as String;
                                        _callPartnerRates(amount: provider.sendAmountController.text, );
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        provider.getCountryFlag(provider.destinationCountry),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        provider.destinationCountry,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Icon(
                                          Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Transfer Type',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(237, 188, 54, 1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                      context, RouterConstants.paymentModeRoute)
                                  .then((value) {
                                if (value != null) {
                                  provider.selectPaymentMode = value as String;
                                  _callPartnerRates(amount: provider.sendAmountController.text);
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  provider.selectPaymentMode,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(135, 7, 7, 7)),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text('Should arrive',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(' by  ${provider.shouldArrive}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.amber)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    RouterConstants.sendingMoneyRoute,
                                  );
                                },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Continue'))),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
