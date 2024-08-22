import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/common_widget/common_property.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/beneficiary_list_model.dart';
import 'package:vitremit/model/partner_transaction_settings_model.dart';
import 'package:vitremit/model/payout_bank_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';

import '../model/partner_source_country_model.dart';

class AddNewRecipientPage extends StatefulWidget {
  const AddNewRecipientPage({Key? key}) : super(key: key);

  @override
  State<AddNewRecipientPage> createState() => _AddNewRecipientPageState();
}

class _AddNewRecipientPageState extends State<AddNewRecipientPage> {
  final _formKey = GlobalKey<FormState>();
  SourceCurrency? dropdownValue;
  PaymentMethodCode? _paymentMethodCode;
  PayoutBank? _payoutBank;

   DashBoardProvider? provider;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final accountNumberController = TextEditingController();
  final mobileCodeController = TextEditingController();

  @override
  void initState() {
    provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {


      if (ModalRoute.of(context)!.settings.arguments != null) {

        final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        Data data = arguments[Constants.recipientUserDetails] as Data;

        fNameController.text = data.beneFirstName;
        lNameController.text = data.beneLastName;
        mobileController.text = data.beneMobileNumber.toString();
        emailController.text = data.beneEmail;
        cityController.text = data.beneCity;

        for (var f in provider!.countryDestinationList!.response[0].destinationCurrency) {
          if (f.currencySupported[0].currency == data.benificiaryCountry) {
            dropdownValue = f;
            mobileCodeController.text = f.mobileCode;
            provider!.getPayoutsBanksList(
                countryCode: f.countryCode);
          }
        }

        for (var res
        in provider!.partnerTransactionSettingsModel!.response.transferTypes) {
          if (data.paymentType == res.code) {
            _paymentMethodCode = res;
            break;
          }
        }

        for (var res
        in provider!.partnerTransactionSettingsModel!.response.transferTypes) {
          if (data.paymentType == res.code) {
            _paymentMethodCode = res;
          }
        }
      } else {
        for (var f in provider!.countryDestinationList!.response[0].destinationCurrency) {
          if (f.currencySupported[0].currency == provider?.destinationCountry) {
            dropdownValue = f;
            mobileCodeController.text = f.mobileCode;
            provider!.getPayoutsBanksList(
                countryCode: f.countryCode);
          }
        }

        for (var res
        in provider!.partnerTransactionSettingsModel!.response.transferTypes) {
          print('=================== ${provider!.selectPaymentMode} == ${res.value}');
          if (provider!.selectPaymentMode.toLowerCase() == res.value) {
            _paymentMethodCode = res;
          }
        }

      }

      provider!.getPayoutsBanksList(countryCode: provider!.destinationCountry);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data? data;
    if(ModalRoute
        .of(context)!
        .settings
        .arguments != null) {
      final arguments =
      ModalRoute
          .of(context)!
          .settings
          .arguments as Map<String, dynamic>;
       data = arguments[Constants.recipientUserDetails] as Data;
    }

    print('=============== ${provider!.countryDestinationList!.response[0].destinationCurrency[0].countryCode}');

    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
              return Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        data == null  ?'Add a new recipient' : 'Edit recipient',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          'Please ensure that you enter accurate information, '
                          'otherwise your transfer may face delays.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        width: 340,
                        child: Text(
                          'Please ensure your recipient\'s name entered here matches the details on their government issued ID as they will need to present it during collection. Any incorrect names could cause a delay when collecting funds.',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'First Name',
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
                          controller: fNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter your name'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Surname',
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
                          controller: lNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please surname name';
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter last name'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Country',
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
                          child: DropdownButton<SourceCurrency>(
                            value: dropdownValue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (SourceCurrency? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                mobileCodeController.text = value.mobileCode;
                                //_paymentMethodCode = null;
                                _payoutBank = null;
                              });
                              provider.getPayoutsBanksList(
                                  countryCode: value!.countryCode, );
                            },
                            hint: const Text('Please select country'),
                            items: provider.countryDestinationList!.response[0].destinationCurrency
                                .map<DropdownMenuItem<SourceCurrency>>(
                                    (SourceCurrency value) {
                              return DropdownMenuItem<SourceCurrency>(
                                value: value,
                                child: Row(
                                  children: [
                                    Image.asset(provider.getCountryFlag(value.currencySupported[0].currency)),
                                    const SizedBox(width: 8,),
                                    Text(value.countryName),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Address',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Town/City',
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
                          controller: cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please your city';
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter your city'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Contact Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black87),
                            ),
                          ),
                          Text(
                            'Optional',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          decoration:
                              editTextProperty(hitText: 'Enter email address'),
                          style: const TextStyle(fontSize: 14),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              enabled: false,
                              controller: mobileCodeController,
                              decoration: editTextProperty(
                                  hitText: '+91'),
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              controller: mobileController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile number';
                                }
                                return null;
                              },
                              decoration: editTextProperty(
                                  hitText: 'Enter Mobile number'),
                              style: const TextStyle(fontSize: 14),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Select Transfer Type',
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
                          child: DropdownButton<PaymentMethodCode>(
                            value: _paymentMethodCode,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (PaymentMethodCode? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _paymentMethodCode = value!;
                              });
                            },
                            hint: const Text(''),
                            items: provider.partnerTransactionSettingsModel!
                                .response.transferTypes
                                .map<DropdownMenuItem<PaymentMethodCode>>(
                                    (PaymentMethodCode value) {
                              return DropdownMenuItem<PaymentMethodCode>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      if (_paymentMethodCode?.name == 'Bill Pay') ...[
                        const SizedBox(
                          height: 14,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Account Number',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: accountNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter account number';
                                  }
                                  return null;
                                },
                                decoration: editTextProperty(
                                    hitText: 'Enter account number'),
                                style: const TextStyle(fontSize: 14),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        ],
                      if (_paymentMethodCode?.name == 'Bank Transfer') ...[
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Select Bank',
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
                            child: DropdownButton<PayoutBank>(
                              value: _payoutBank,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(),
                              isExpanded: true,
                              onChanged: (PayoutBank? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  _payoutBank = value!;
                                });
                              },
                              hint: const Text(''),
                              items: provider.payoutBankModel?.response
                                  ?.map<DropdownMenuItem<PayoutBank>>(
                                      (PayoutBank value) {
                                return DropdownMenuItem<PayoutBank>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final loginProvider =
                                    Provider.of<LoginProvider>(
                                  context,
                                  listen: false,
                                );
                                final req = {
                                  'bene_first_name': fNameController.text,
                                  'bene_last_name': lNameController.text,
                                  'bene_city': cityController.text,
                                  'bene_mobile_number': data != null ? mobileController.text :
                                      '${dropdownValue?.mobileCode}${mobileController.text}',
                                  'bene_email': emailController.text,
                                  'remitter_id': loginProvider
                                      .userInfo!.userDetails!.remitterId,
                                  'partner_id': loginProvider
                                      .userInfo!.userDetails!.partnerId,
                                  'benificiary_country':
                                      dropdownValue?.currencySupported[0].currency,
                                  'bene_address': '',
                                  'bene_card_number': '',
                                  'bene_payment_type': '${_paymentMethodCode!.code}',
                                  if(_paymentMethodCode?.name == 'Bank Transfer')'bene_bank_details': _paymentMethodCode!.code == 1
                                      ? ''
                                      : {"bank": '${_payoutBank?.name}',"bank_ifsc_code": '${_payoutBank?.code}'},
                                  if(_paymentMethodCode?.name == 'Bill Pay') 'bene_billpay_accountno': accountNumberController.text,
                                  'transfer_type_po': _paymentMethodCode?.value ?? '',
                                };

                                if(data != null){
                                  req['bene_id'] = data.beneId;
                                }

                                try {
                                  (data == null)
                                      ? await provider.beneficiaryCreate(
                                          data: req)
                                      : await provider.beneficiaryUpdate(
                                          data: req);
                                  if (mounted) {
                                    Fluttertoast.showToast(
                                        msg: (data == null)
                                            ? 'Recipient successfully added!'
                                            : 'Recipient successfully updated!');
                                    Navigator.pop(context);
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
                                : const Text("Continue")),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
