import 'package:flutter/material.dart';
import 'package:indigo24/main.dart';
import 'package:indigo24/services/api/http/api.dart';
import 'package:indigo24/style/colors.dart';
import 'package:indigo24/widgets/alerts/indigo_alert.dart';
import 'package:indigo24/widgets/indigo_ui_kit/indigo_appbar_widget.dart';
import 'package:indigo24/widgets/service_widget.dart';
import 'payments_service.dart';
import 'package:indigo24/services/constants.dart';

class PaymentsServices extends StatefulWidget {
  final int categoryID;
  final String title;
  final int locationId;
  final String locationType;
  PaymentsServices(this.categoryID, this.title,
      {this.locationId, this.locationType});

  @override
  _PaymentsServicesState createState() => _PaymentsServicesState();
}

class _PaymentsServicesState extends State<PaymentsServices> {
  Api _api;

  Map<String, dynamic> _services;

  @override
  void initState() {
    super.initState();

    _api = Api();

    if (widget.locationId != null && widget.locationType != null) {
      _api
          .getServices(
        widget.categoryID,
        locationId: widget.locationId,
        locationType: widget.locationType,
      )
          .then(
        (services) {
          if (services['message'] == 'Not authenticated' &&
              services['success'].toString() == 'false') {
            logOut(context);
          } else if (services['success'].toString() == 'false') {
            CustomDialog(
              description: services['message'],
              yesCallBack: () {
                Navigator.pop(context);
              },
            );
          } else {
            setState(() {
              _services = services;
            });
          }
        },
      );
    } else {
      _api.getServices(widget.categoryID).then((services) {
        if (services['message'] == 'Not authenticated' &&
            services['success'].toString() == 'false') {
          logOut(context);
        } else {
          setState(() {
            _services = services;
          });
        }
      });
    }
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
          widget.title,
          style: TextStyle(
            color: blackPurpleColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: _services != null
          ? SafeArea(
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  shrinkWrap: true,
                  itemCount: _services["services"] != null
                      ? _services["services"].length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic service = _services["services"][index];
                    String servieLogo = "$logos${service['logo']}";
                    String serviceTitle = "${service['title']}";
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ServiceWidget(
                        logo: servieLogo,
                        title: serviceTitle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentsServicePage(
                                service['id'],
                                servieLogo,
                                serviceTitle,
                                isConvertable: service['is_convertable'],
                                providerId: service['provider_id'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
