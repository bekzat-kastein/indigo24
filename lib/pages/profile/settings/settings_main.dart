import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indigo24/pages/profile/settings/settings_language.dart';
import 'package:indigo24/pages/profile/settings/settings_notifications_main.dart';
import 'package:indigo24/pages/profile/settings/settings_sound.dart';
import 'package:indigo24/pages/profile/settings/settings_terms.dart';
import 'package:indigo24/services/localization.dart' as localization;
import 'package:indigo24/services/api/socket/socket.dart';
import 'package:indigo24/style/colors.dart';
import 'package:indigo24/widgets/indigo_ui_kit/indigo_appbar_widget.dart';
import 'settings_decor.dart';

class SettingsMainPage extends StatefulWidget {
  @override
  _SettingsMainPageState createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  Map<String, dynamic> _settings;

  @override
  void initState() {
    _listen();
    ChatRoom.shared.getUserSettings();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: IndigoAppBarWidget(
          title: Text(
            "${localization.settings}",
            style: TextStyle(
              color: blackPurpleColor,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _settingsRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SettingsNotificationsMainPage(
                                      settings: _settings),
                            ),
                          ).whenComplete(
                            () => setState(
                              () {
                                ChatRoom.shared.getUserSettings();
                              },
                            ),
                          );
                        },
                        title: localization.notifications,
                      ),
                      _settingsRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsDecorPage(),
                            ),
                          ).whenComplete(
                            () => setState(() {}),
                          );
                        },
                        title: localization.decor,
                      ),
                      _settingsRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsLanguagePage(),
                            ),
                          ).whenComplete(
                            () => setState(() {}),
                          );
                        },
                        title: localization.language,
                        subtext: localization.currentLanguage,
                      ),
                      _settingsRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsTermsPage(),
                            ),
                          ).whenComplete(
                            () => setState(() {}),
                          );
                        },
                        title: localization.terms,
                      ),
                      _settingsRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsSoundPage(),
                            ),
                          ).whenComplete(
                            () => setState(() {}),
                          );
                        },
                        title: localization.sound,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _listen() {
    ChatRoom.shared.settingsStream.listen((e) {
      print("Settings EVENT");
      var cmd = e.json['cmd'];
      var message = e.json['data'];

      switch (cmd) {
        case "user:settings:get":
          _settings = message;
          break;
        default:
          print('Default of settings $message');
      }
    });
  }

  _settingsRow({
    @required Function onTap,
    @required String title,
    String subtext,
  }) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: blackPurpleColor,
                ),
              ),
              Row(
                children: [
                  if (subtext != null)
                    Text(
                      subtext,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackPurpleColor,
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image(
                      image: AssetImage(
                        'assets/images/forward.png',
                      ),
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
