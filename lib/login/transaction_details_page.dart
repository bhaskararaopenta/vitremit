import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/transaction_details_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';

class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({super.key});

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {

  String? changeDate(String? date){
    DateTime now = DateTime.parse(date??'');
    String formattedDate = DateFormat('dd/MM/yyyy, hh:mm a').format(now.toLocal());
    return formattedDate;
  }

  Widget getDetails({required String? title, required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  void initState() {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    provider.transactionDetailsModel = null;

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        String transRef = arguments[Constants.transRef] as String;
        provider.transactionDetailsAPI(transactionId: transRef);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DashBoardProvider>(
          builder: (_,provider,__) {
            TransactionDetailsModel? transactionDetailsModel = provider.transactionDetailsModel;
            if(transactionDetailsModel == null){
              return Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Transactions Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Transactions Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getDetails(
                    title: 'Transaction Ref:',
                    value: '${transactionDetailsModel.response?.transSessionId}',
                  ),
                  getDetails(
                    title: 'Recipient:',
                    value: '${transactionDetailsModel.response?.beneficiaryFirstName} ${transactionDetailsModel.response?.beneficiaryLastName} ',
                  ),
                  getDetails(
                    title: 'Recipient Mobile Number:',
                    value: '${transactionDetailsModel.response?.beneficiaryMobileNumber}',
                  ),
                  getDetails(
                    title: 'Source Country:',
                    value: '${transactionDetailsModel.response?.sourceCountry}',
                  ),
                  getDetails(
                    title: 'Source Amount:',
                    value: '${transactionDetailsModel.response?.sourceAmount}',
                  ),
                  getDetails(
                    title: 'Dest Country:',
                    value: '${transactionDetailsModel.response?.destinationCountry}',
                  ),
                  getDetails(
                    title: 'Dest Amount:',
                    value: '${transactionDetailsModel.response?.destinationAmount}',
                  ),
                  getDetails(
                    title: 'Source of Income:',
                    value: '${transactionDetailsModel.response?.sourceOfIncome}',
                  ),
                  getDetails(
                    title: 'Purpose:',
                    value: '${transactionDetailsModel.response?.purpose}',
                  ),
                  getDetails(
                    title: 'Status:',
                    value: '${transactionDetailsModel.response?.transactionStatus}',
                  ),
                  getDetails(
                    title: 'Create Date:',
                    value: '${changeDate(transactionDetailsModel.response?.createdAt)}',
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
