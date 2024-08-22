import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitremit/constants/common_constants.dart';
import 'package:vitremit/constants/constants.dart';
import 'package:vitremit/model/beneficiary_list_model.dart';
import 'package:vitremit/provider/dashboard_provider.dart';
import 'package:vitremit/provider/login_provider.dart';
import 'package:vitremit/router/router.dart';

class SendingMoneyPage extends StatefulWidget {
  const SendingMoneyPage({super.key});

  @override
  State<SendingMoneyPage> createState() => _SendingMoneyPageState();
}

class _SendingMoneyPageState extends State<SendingMoneyPage> {
  int _selectedIndex = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchRecipientList();
    });
    super.initState();
  }

  Future<void> fetchRecipientList() async {
    final provider = Provider.of<DashBoardProvider>(
      context,
      listen: false,
    );

    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    await provider.getBeneficiaryList(
        remitterId: loginProvider.userInfo!.userDetails!.remitterId!);
  }

  Widget getWidget(int id, String imagePath, Data? data) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          onTapDown: (_) {
            setState(() {
              _selectedIndex = id;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
                color: id == _selectedIndex ? Colors.blueAccent : Colors.white),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data?.beneFirstName} ${data?.beneLastName}',
                        style: TextStyle(
                            color: id == _selectedIndex
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'From ${data?.beneCity}',
                        style: TextStyle(
                            color: id == _selectedIndex
                                ? Colors.white54
                                : Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (getUserStatus()) {
                        Navigator.pushNamed(
                            context, RouterConstants.addNewRecipientRoute,
                            arguments: {Constants.recipientUserDetails: data});
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      color:
                          id == _selectedIndex ? Colors.white54 : Colors.black,
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  bool getUserStatus() {
    final loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    if (loginProvider.userInfo?.userDetails?.kycStatus.toUpperCase() !=
            'KYC-SENT' &&
        loginProvider.userInfo?.userDetails?.amlStatus.toUpperCase() !=
            'AML-SENT') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Go and Complete their profile.'),
      ));

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 236, 247, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Consumer<DashBoardProvider>(builder: (_, provider, __) {
            var userList = [];

            if (provider.beneficiaryListModel != null) {
              for (var res in provider.beneficiaryListModel!.data) {
                print('transferType======== ${res.transferType}');
                print(
                    'selectPaymentMode======== ${provider.selectPaymentMode}');
                if (provider.selectPaymentMode.toLowerCase() ==
                    res.transferType?.toLowerCase()) {
                  userList.add(res);
                }
              }
            }

            userList = userList ?? [];

            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Who are you sending \nmoney to?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (getUserStatus()) {
                              Navigator.pushNamed(context,
                                      RouterConstants.addNewRecipientRoute)
                                  .then((value) {
                                fetchRecipientList();
                              });
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        const Text(
                          'Add a new recipient',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'or choose on existing recipient',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black38),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: provider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return getWidget(index,
                                AssetsConstant.girlImageIcon, userList[index]);
                          }),
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
                      onPressed: _selectedIndex == -1
                          ? null
                          : () {
                              if (getUserStatus()) {
                                Navigator.pushNamed(context,
                                    RouterConstants.transferDetailRoute,
                                    arguments: {
                                      Constants.recipientUserDetails: userList[_selectedIndex]
                                    });
                              }
                            },
                      child: const Text("Next")),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
