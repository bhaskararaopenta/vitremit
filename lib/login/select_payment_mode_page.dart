import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/model/partner_transaction_settings_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';

class SelectPaymentModePage extends StatefulWidget {
  const SelectPaymentModePage({Key? key}) : super(key: key);

  @override
  State<SelectPaymentModePage> createState() => _SelectPaymentModePageState();
}

class _SelectPaymentModePageState extends State<SelectPaymentModePage> {

  @override
  void initState() {
    super.initState();
  }

  Widget getWidget(DashBoardProvider provider, String imagePath, PaymentMethodCode data) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, data.value);
      },
      onTapDown: (_){
         provider.selectPaymentMode = data.value!;
      },
      onTapCancel: (){
        provider.selectPaymentMode = data.value!;
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: data.value == provider.selectPaymentMode ? Colors.blueAccent : Colors.white),
        padding: const EdgeInsets.all(16),
        child: Text(
          data.name,
          style: TextStyle(
              color: data.value == provider.selectPaymentMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
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
                  'Select Payment Mode',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 300,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Molestie viverra feugiat malesuada pharetra.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black26),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<DashBoardProvider>(
                    builder: (_, provider, __) {
                      return ListView.builder(
                        itemCount: provider.partnerTransactionSettingsModel?.response.transferTypes == null ? 0
                            : provider.partnerTransactionSettingsModel?.response.transferTypes.length,
                          itemBuilder: (context, index){
                            return getWidget(provider, AssetsConstant.rwandaFlagIcon, provider.partnerTransactionSettingsModel!.response.transferTypes[index]);
                      });
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
