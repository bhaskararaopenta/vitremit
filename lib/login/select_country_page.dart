import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/partner_source_country_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({Key? key}) : super(key: key);

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<DashBoardProvider>(
        context,
        listen: false,
      );
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        bool isComingFromSignUpPage = arguments[Constants.isComingFromSignUpPage] as bool;
        await provider.getCountryList(isComingFromSignUP: isComingFromSignUpPage);
      } else {
        if (provider.countryModel == null) {
          await provider.getCountryList();
        } else if (provider.countryDestinationList == null) {
          await provider.getCountryDestinationList();
        }
      }
    });
    super.initState();
  }

  Widget getWidget(DashBoardProvider provider, SourceCurrency data, String type) {
    return GestureDetector(
      onTap: () {
        provider.sourceCountryName = data.countryName;

        if(type == 'source'){
          provider.sourceCurrency = data.countryCode;
        } else if(type == 'destination'){
          provider.destinationCurrency = data.countryCode;
        }

        Navigator.pop(context, data.currencySupported[0].currency);
      },
      onTapDown: (_) {
        provider.selectCountryCodeByUser(data.countryCode);
      },
      onTapCancel: () {
        provider.selectCountryCodeByUser('');
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: data.countryCode == provider.selectCountryCode ? Colors
                .blueAccent : Colors.white),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              provider.getCountryFlag(data.currencySupported[0].currency),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data.countryName,
              style: TextStyle(
                  color: data.countryCode == provider.selectCountryCode ? Colors
                      .white : Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ],
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
                  'Select Country',
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
                      PartnerCountryModel? countryList = provider
                          .whichTypeCountryMode == Constants.showSourceCountry
                          ? provider.countryModel : provider
                          .countryDestinationList;
                      print(provider.whichTypeCountryMode);


                      return provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          :
                      provider.whichTypeCountryMode ==
                          Constants.showSourceCountry
                          ? ListView.builder(
                        itemCount: countryList == null ? 0 : countryList
                            .response[0].sourceCurrency.length,
                        itemBuilder: (context, index) {
                          return getWidget(provider,
                              countryList!.response[0].sourceCurrency[index], 'source');
                        },)
                      : ListView.builder(
                        itemCount: countryList == null ? 0 : countryList
                            .response[0].destinationCurrency.length,
                        itemBuilder: (context, index) {
                          return getWidget(provider,
                              countryList!.response[0].destinationCurrency[index], 'destination');
                        },);
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
