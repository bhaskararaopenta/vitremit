import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';

import '../model/transaction_list_model.dart';
import '../provider/dashboard_provider.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
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
      provider.transactionListAPI(data: {
        //'remitter_id': loginProvider.userInfo?.userDetails?.remitterId
        "data": "RemitterId"
      });
    });
    super.initState();
  }

  Widget transactionItem(TransactionModel model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouterConstants.transactionDetailsRoute,
          arguments: {Constants.transRef: model.transSessionId ?? ''},
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(model.dateFormat())),
              Text(
                model.transactionStatus ?? '',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.black87,
                height: 2,
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Recipient',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${model.beneficiaryFirstName} ${model.beneficiaryLastName}'
                    .toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Transaction ID',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                model.transSessionId ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Currency',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                model.sourceCurrency ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '${model.sourceAmount ?? 0}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'My Transactions',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 48,
              //         child: TextFormField(
              //           decoration: editTextProperty(hitText: 'Search', icon: Icons.search_rounded),
              //           style: const TextStyle(fontSize: 14),
              //           onChanged: (value) {},
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 10,),
              //     ElevatedButton(onPressed: (){}, child: const Text('Filter'))
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DashBoardProvider>(builder: (_, provider, __) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.transactionList == null || provider.transactionList!.response!.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('No transaction list found...'),
                    ),
                  );
                }
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...?provider.transactionList?.response?.map((e) {
                          return transactionItem(e);
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
