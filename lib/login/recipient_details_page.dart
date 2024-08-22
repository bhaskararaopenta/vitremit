import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/beneficiary_list_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';

class RecipientDetailsPage extends StatefulWidget {
  const RecipientDetailsPage({Key? key}) : super(key: key);

  @override
  State<RecipientDetailsPage> createState() => _RecipientDetailsPageState();
}

class _RecipientDetailsPageState extends State<RecipientDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Data data = arguments[Constants.recipientUserDetails] as Data;
    String? sourceOfIncome = arguments[Constants.sourceOfIncome] as String;
    String? purposeOf = arguments[Constants.purposeOf] as String;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Recipient Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(AssetsConstant.girlImageIcon),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${data.beneFirstName} ${data.beneLastName}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.phone,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                            width: 110,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: Text(
                          '${data.beneEmail}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.locationPin,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                            width: 110,
                            child: Text(
                              'City',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: Text(
                          data.beneCity ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.locationPin,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                            width: 110,
                            child: Text(
                              'Mobile Number',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: Text(
                          '${data.beneMobileNumber}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   FontAwesomeIcons.locationPin,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                            width: 110,
                            child: Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: Text(
                          data.beneAddress ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<DashBoardProvider>(
                          builder: (_, provider, __) {
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
                                    final reqData = {
                                      "amount_type": "SOURCE",
                                      "beneficiary_id": data.beneId,
                                      "compliance_checked": false,
                                      "compliance_needed": false,
                                      "destination_account": "",
                                      "destination_amount":
                                          provider.receiveAmountController.text,
                                      "destination_country":
                                          provider.destinationCurrency,
                                      "destination_currency":
                                          provider.destinationCountry,
                                      "ext_compliance_checked": false,
                                      "ext_compliance_needed": false,
                                      "payer_name ": "",
                                      "payment_token": "",
                                      "payment_type_pi":
                                          provider.selectPaymentType,
                                      "promotion_code": "",
                                      "purpose": purposeOf,
                                      "remitter_wallet_currency": "",
                                      "service_level": 1,
                                      "sms_benef_confirmation": false,
                                      "sms_confirmation": false,
                                      "sms_mobile": "",
                                      "sms_notification": false,
                                      "source_amount":
                                          provider.sendAmountController.text,
                                      "source_country": provider.sourceCurrency,
                                      "source_currency": provider.sourceCountry,
                                      "source_of_income": sourceOfIncome,
                                      "transfer_type_po":
                                          provider.selectPaymentMode,
                                      "channel": 'mobile'
                                    };
                                    try {
                                      final res = await provider
                                          .transactionCreateAPI(data: reqData);
                                      if (res.success && mounted) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Recipient successfully Created!');
                                        Navigator.of(context).pushNamed(
                                            res.data.settlementAccountInfo !=
                                                    null
                                                ? RouterConstants
                                                    .paymentDetailRoute
                                                : RouterConstants
                                                    .paymentHTMLRoute,
                                            arguments: {
                                              Constants.amount: provider
                                                  .sendAmountController.text,
                                              Constants.currency:
                                                  provider.destinationCountry,
                                              Constants.transferType:
                                                  provider.selectPaymentType,
                                              Constants.createTransaction: res,
                                            });
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    } finally {
                                      provider.setLoadingStatus(false);
                                    }
                                  },
                            child: provider.isLoading
                                ? const CircularProgressIndicator()
                                : const Text("Continue"));
                      }),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
