import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/common_widget/common_property.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/beneficiary_list_model.dart';
import 'package:vitremit/model/partner_transaction_settings_model.dart';
import 'package:vitremit/model/payout_bank_model.dart';
import 'package:vitremit/model/register_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';

import '../model/partner_source_country_model.dart';

class TransferDetailsPage extends StatefulWidget {
  const TransferDetailsPage({Key? key}) : super(key: key);

  @override
  State<TransferDetailsPage> createState() => _TransferDetailsPageState();
}

class _TransferDetailsPageState extends State<TransferDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  Response? dropdownValue;
  DashBoardProvider? _provider;
  Code? sourceOfIncome;
  Code? purposeCodes;

  @override
  void initState() {
    _provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data? data;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      data = arguments[Constants.recipientUserDetails] as Data;
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Transfer Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'To help us keep this transaction safeand secure, please complete the below and ensure the transfer details are correct before continuing.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Source of income',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  //background color of dropdown button
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownButton<Code>(
                    value: sourceOfIncome,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(),
                    isExpanded: true,
                    onChanged: (Code? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        sourceOfIncome = value!;
                      });
                    },
                    hint: const Text('Please select'),
                    items: _provider?.partnerTransactionSettingsModel?.response
                        .sourceOfIncomeCodes
                        .map<DropdownMenuItem<Code>>((Code value) {
                      return DropdownMenuItem<Code>(
                        value: value,
                        child: Text(value.name!),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Purpose of remittance',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  //background color of dropdown button
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownButton<Code>(
                    value: purposeCodes,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(),
                    isExpanded: true,
                    onChanged: (Code? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        purposeCodes = value!;
                      });
                    },
                    hint: const Text('Please select'),
                    items: _provider?.partnerTransactionSettingsModel?.response
                        .remittancePurposeCodes
                        .map<DropdownMenuItem<Code>>((Code value) {
                      return DropdownMenuItem<Code>(
                        value: value,
                        child: Text(value.name!),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onPressed: () {
                      if(sourceOfIncome != null && purposeCodes != null) {
                        Navigator.pushNamed(
                            context, RouterConstants.paymentTypeRoute,
                            arguments: {
                              Constants.recipientUserDetails: data,
                              Constants.sourceOfIncome: sourceOfIncome?.name,
                              Constants.purposeOf: purposeCodes?.name
                            });
                      }else{
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Please select transfer details'),
                        ));
                      }
                    },
                    child: const Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
