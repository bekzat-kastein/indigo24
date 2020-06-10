import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/api.dart';
import 'transfer.dart';
import 'transfer_history.dart';

class TransferListPage extends StatefulWidget {
  @override
  _TransferListPageState createState() => _TransferListPageState();
}

class _TransferListPageState extends State<TransferListPage> {
  Api api = new Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: mainScreen(context)),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      brightness: Brightness.light,
      title: Text(
        "Переводы",
        style: TextStyle(
          color: Color(0xFF001D52),
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.history,
            color: Colors.black,
          ),
          onPressed: () {
            // StudentDao().deleteAll();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransferHistoryPage()),
            );
          },
        )
      ],
      backgroundColor: Colors.white,
    );
  }

  Widget mainScreen(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        transferlist(context),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container transferlist(BuildContext context) {
    return Container(
      height: 60,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Image.asset('assets/mobileShopPurple.png', width: 30.0),
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Клиенту Indigo",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransferPage()),
          );
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
