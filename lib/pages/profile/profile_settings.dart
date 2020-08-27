import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indigo24/services/api.dart';
import 'package:indigo24/services/helper.dart';
import 'package:indigo24/services/user.dart' as user;
import 'package:indigo24/services/localization.dart' as localization;
import 'package:indigo24/style/colors.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  TextEditingController _nameController;
  Api _api;
  @override
  void initState() {
    _nameController = TextEditingController(text: user.name);
    _api = Api();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  showCustomDialog(BuildContext context, String message) async {
    Widget okButton = CupertinoDialogAction(
      child: Text("OK"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          "${localization.profile}",
          style: TextStyle(
            color: blackPurpleColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('${localization.save}'),
            // Container(
            //   height: 20,
            //   width: 20,
            //   child: Image(
            //     image: AssetImage(
            //       'assets/images/save.png',
            //     ),
            //   ),
            // ),
            onPressed: () async {
              if (_nameController.text.isNotEmpty) {
                _api.settingsSave(name: _nameController.text).then((result) {
                  if (result['success'].toString() == 'true') {
                    user.name = _nameController.text;
                    SharedPreferencesHelper.setString(
                      'name',
                      _nameController.text,
                    );
                    showCustomDialog(context, result['message']);
                  }
                });
              }
            },
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _buildEditor(
                size,
                '${localization.name}',
                '${user.name}',
                readyOnly: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditor(
    Size screenSize,
    String text,
    String initialValue, {
    bool readyOnly = false,
  }) {
    return Center(
      child: Container(
        width: screenSize.width / 1.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text),
            SizedBox(height: 5),
            TextFormField(
              readOnly: readyOnly,
              controller: _nameController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 18, color: blackPurpleColor),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}