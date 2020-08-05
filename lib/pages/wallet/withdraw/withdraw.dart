import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:indigo24/services/api.dart';
import 'package:indigo24/services/constants.dart';
import 'package:indigo24/services/localization.dart' as localization;
import 'package:indigo24/style/colors.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  bool preLoaderForRefill = false;
  var commission = '0';
  final amountController = TextEditingController();

  Api api = Api();

  @override
  void dispose() {
    api.getBalance();
    super.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  WillPopScope buildWebviewScaffold(url) {
    print(' this is url $url');
    print(' this is url $url');
    print(' this is url $url');
    print(' this is url $url');
    print(' this is url $url');
    print(' this is url $url');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage(
                  'assets/images/back.png',
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          brightness: Brightness.light,
          title: Text(
            "${localization.withdraw}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: WebviewScaffold(
              url: '$url',
              withZoom: true,
              withLocalStorage: true,
              hidden: false,
              initialChild: Center(child: CircularProgressIndicator())),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: milkWhiteColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage(
                  'assets/images/back.png',
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          brightness: Brightness.light,
          title: Text(
            "${localization.withdraw}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              Center(
                  child: Text(
                      '${localization.commission} ${withdrawCommission}%')),
              Center(
                  child: Text('${localization.minAmount} ${withdrawMin} KZT')),
              Center(
                  child: Text(
                      '${localization.minCommission} ${withdrawMinCommission} KZT')),
              Center(
                  child: Text('${localization.maxAmount} ${withdrawMax} KZT')),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(withdrawMax.length)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration.collapsed(
                    hintText: '${localization.amount}',
                  ),
                  style: TextStyle(fontSize: 20),
                  controller: amountController,
                  onChanged: (String text) async {
                    if (amountController.text.isNotEmpty) {
                      if (int.parse(amountController.text) > 0) {
                        print('if > 0 $text');
                        if (int.parse(amountController.text) < 1000) {
                          print('if < 1000 $text');
                          setState(() {
                            commission = '0';
                          });
                        } else {
                          print('else $text');
                          if (double.parse(text) <= double.parse(withdrawMax)) {
                            setState(() {
                              commission = (int.parse(text) *
                                      double.parse(withdrawCommission) /
                                      100)
                                  .toStringAsFixed(2);
                            });
                          }
                        }
                      }
                      if (double.parse(commission) <=
                          double.parse(withdrawMinCommission)) {
                        print('if < 350 $text');

                        setState(() {
                          commission = '$withdrawMinCommission';
                        });
                      }
                    } else {
                      setState(() {
                        commission = '0';
                      });
                    }
                  },
                ),
              ),
              Center(child: Text('${localization.commission} $commission KZT')),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: -2,
                          offset: Offset(0.0, 0.0))
                    ]),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 100.0,
                  child: FlatButton(
                    onPressed: () async {
                      if (amountController.text.isNotEmpty) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          preLoaderForRefill = true;
                        });
                        api
                            .withdraw(amountController.text)
                            .then((withdrawResult) {
                          print('Withdraw result $withdrawResult');
                          setState(() {
                            preLoaderForRefill = false;
                          });
                          if (withdrawResult['success'].toString() == 'true') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => buildWebviewScaffold(
                                        withdrawResult['result']
                                            ['redirectURL'])));
                          } else {
                            Widget okButton = CupertinoDialogAction(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            CupertinoAlertDialog alert = CupertinoAlertDialog(
                              title: Text("${localization.attention}"),
                              content: Text(withdrawResult['message']),
                              actions: [
                                okButton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                          print(withdrawResult);
                        });
                      }
                    },
                    child: Text(
                      '${localization.withdraw}',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
