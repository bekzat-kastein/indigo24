import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:indigo24/services/user.dart' as user;
import 'package:indigo24/services/configs.dart' as configs;
import 'package:indigo24/services/constants.dart';
import 'package:indigo24/widgets/progress_bar.dart';

import 'helper.dart';

class Api {
  Response response;

  static BaseOptions options = new BaseOptions(
    baseUrl: "$baseUrl",
    connectTimeout: 15000,
    receiveTimeout: 3000,
  );

  Dio dio = new Dio(options);
  static const sendSmsToken = "2MSldk_7!FUh3zB18XoEfIe#nY69@0tcP5Q4";
  static const registrationToken = "BGkA2as4#h_J@5txId3fEq6e!F80UMj197ZC";
  static const checkPhoneToken = "EG#201wR8Wk6ZbvMFf_e@39h7V!tI5gBTx4a";
  var device = 'deviceName';
  // @TODO change device NAME;
  register(phone, name, password, email) async {
    try {
      response = await dio.post("/registration", data: {
        "name": "$name",
        "password": "$password",
        "email": "$email",
        "phone": "$phone",
        "_token": "$registrationToken",
        "device": "$device",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  var _configToken = "D@Xo8b56r#7e1iZElhH39xK!WkB_42vYAG0p";

  getConfig() async {
    print('Getting configs');
    try {
      response = await dio.post("/get/config", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "_token": "$_configToken",
      });
      var commission = response.data['commissions'];
      var withdrawConfig = commission['withdraw'];
      var refillConfig = commission['refill'];
      configs.withdrawCommission = '${withdrawConfig['commission']}';
      configs.withdrawMinCommission = '${withdrawConfig['minCommission']}';
      configs.withdrawMin = '${withdrawConfig['min']}';
      configs.withdrawMax = '${withdrawConfig['max']}';

      configs.refillCommission = '${refillConfig['commission']}';
      configs.refillMinCommission = '${refillConfig['minCommission']}';
      configs.refillMin = '${refillConfig['min']}';
      configs.refillMax = '${refillConfig['max']}';
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request.data);
      } else {
        print('get config error');
      }
      return e.response.data;
    }
  }

  updateFCM(token) async {
    print('updating token is called');
    try {
      response = await dio.post("/token/fcm/update", data: {
        "customerID": "${user.id}",
        "token": "$token",
        "unique": "${user.unique}"
      });
      if (response.data['success'] == true) {
        print("Token updated to $token ${response.data}");
        return true;
      } else {
        print("Else token updated to $token ${response.data}");
        return response.data;
      }
    } on DioError catch (e) {
      print('This is error ${e.request.data}');
      if (e.response != null) {
        print('This is error $e when response is not null');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print('This is error $e when response is null');
        print(response.statusCode);
        print(e.response.statusCode);
        return false;
      }
    }
  }

  checkRegistration(phone) async {
    try {
      response = await dio.post("/check/registration", data: {
        "phone": "$phone",
        "_token": "$checkPhoneToken",
      });
      print(response.request.data);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getHistoryBalance(page) async {
    try {
      response = await dio.post("/get/balance/history", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "page": "$page",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  logOutHttp() async {
    try {
      response = await dio.post("/logout", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
      });
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  sendSms(phone) async {
    try {
      response = await dio.post("/sms/send", data: {
        "phone": "$phone",
        "_token": "$sendSmsToken",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  restorePassword(phone) async {
    try {
      response = await dio.post("/restore", data: {"phone": "$phone"});
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  getService(serviceID) async {
    try {
      response = await dio.post("/get/payments", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "serviceID": "$serviceID"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is sms ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  checkSms(phone, code) async {
    try {
      response = await dio
          .post("/check/sms", data: {"phone": "$phone", "code": "$code"});
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is sms ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  createPin(pinCode) async {
    try {
      response = await dio.post("/create/pin", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "pinCode": "$pinCode"
      });
      if (response.data['success'] == true) {
        SharedPreferencesHelper.setString('pin', '$pinCode');
        user.pin = '$pinCode';
      }
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  getBalance() async {
    try {
      response = await dio.post("/get/balance",
          data: {"customerID": "${user.id}", "unique": "${user.unique}"});
      if (response.data['success'] == true) {
        SharedPreferencesHelper.setString(
            'balance', '${response.data['result']['balance']}');
        SharedPreferencesHelper.setString(
            'balanceInBlock', '${response.data['result']['balanceInBlock']}');
        user.balance = '${response.data['result']['balance']}';
        user.balanceInBlock = '${response.data['result']['balanceInBlock']}';

        print("Balance in block ${user.balanceInBlock}");
        return response.data;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is get_balance ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  signIn(phone, password) async {
    try {
      response = await dio.post("/check/authentication", data: {
        "phone": "$phone",
        "password": "$password",
      });
      if (response.data['success'] == true) {
        SharedPreferencesHelper.setString(
            'customerID', '${response.data['ID']}');
        SharedPreferencesHelper.setString('phone', '+$phone');
        SharedPreferencesHelper.setString('name', '${response.data['name']}');
        SharedPreferencesHelper.setString('email', '${response.data['email']}');
        SharedPreferencesHelper.setString(
            'avatar', '${response.data['avatar']}');
        SharedPreferencesHelper.setString(
            'unique', '${response.data['unique']}');
        SharedPreferencesHelper.setString('pin', '${response.data['pin']}');
        user.id = '${response.data['ID']}';
        user.phone = '+$phone}';
        user.name = '${response.data['name']}';
        user.email = '${response.data['email']}';
        user.avatar = '${response.data['avatar']}';
        user.unique = '${response.data['unique']}';
        user.pin = '${response.data['pin']}';
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        String token = await _firebaseMessaging.getToken();
        await updateFCM(token);
        return response.data;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is login ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        // print(response.statusCode);
        // print(e.response.statusCode);
      }
      return e.response.data;
    }
  }

  checkUnique(newUnique, newCustomerID) async {
    try {
      response = await dio.post("/check/token",
          data: {"customerID": "$newCustomerID", "unique": "$newUnique"});
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('e response is unique ${e.response}');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request.data);
        return e.response.data;
      } else {
        print('$e this dio error');
        return false;
        // print(response.statusCode);
        // print(e.response.statusCode);
        // return e.response.data;
      }
    }
  }

  withdraw(amount) async {
    try {
      String _token = "1E#cw!5yofLCB3b_DX07x@4uKT6FH9mta8J2";
      response = await dio.post("/pay/out", data: {
        "_token": "$_token",
        "amount": "$amount",
        "customerID": "${user.id}",
        "unique": "${user.unique}"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  doTransfer(toID, amount, {transferChat}) async {
    try {
      if (transferChat == null) {
        response = await dio.post("/check/send/money", data: {
          "customerID": "${user.id}",
          "unique": "${user.unique}",
          "toID": "$toID",
          "amount": "$amount",
        });
      } else {
        response = await dio.post("/check/send/money", data: {
          "customerID": "${user.id}",
          "unique": "${user.unique}",
          "toID": "$toID",
          "amount": "$amount",
          'chatTransfer': '1',
        });
      }

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request.uri);
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getTransactions(page) async {
    try {
      response = await dio.post("/get/transactions", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "page": "$page",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  checkPhoneForSendMoney(phone) async {
    try {
      response = await dio.post("/check/send/money/phone", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "phone": "$phone",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  payService(serviceID, account, amount) async {
    try {
      response = await dio.post("/service/pay", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "serviceID": "$serviceID",
        "amount": "$amount",
        "account": "$account",
      });
      print(response.request.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getServices(categoryID) async {
    try {
      response = await dio.post("/get/services", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "categoryID": "$categoryID"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getHistories(page) async {
    try {
      response = await dio.post("/get/histories", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "page": "$page"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  refill(amount) async {
    try {
      String _token = "UGfbx#Du61zSNiXgjm4E!@M2OFJ98t3075_e";
      response = await dio.post("/pay/in", data: {
        "_token": "$_token",
        "amount": "$amount",
        "customerID": "${user.id}",
        "unique": "${user.unique}"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getCategories() async {
    try {
      response = await dio.post("/get/categories",
          data: {"customerID": "${user.id}", "unique": "${user.unique}"});
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getCountries() async {
    try {
      response = await dio.post("/get/countries", data: {
        "_token": "8F@RgTHf7Ae1_M#Lv0!K4kmcNb6por52QU39",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        return false;
        // print(e.response.statusCode);
      }
    }
  }

  getExchangeRate() async {
    print("Getting exchanges for ${user.id} with ${user.unique}");
    String exchangeToken = '#8kX1xtDr4qSY8_C9!N@cC9bvT0Pilk85DS32';
    try {
      response = await dio.post("/get/exchanges", data: {
        "_token": "$exchangeToken",
        "customerID": "${user.id}",
        "unique": "${user.unique}"
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  likeTape(String tapeId) async {
    try {
      response = await dio.post("/tape/like", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "tapeID": "$tapeId",
      });
      print("LIKE TAPE ${response.data}");

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getTapes(String page) async {
    try {
      response = await dio.post("/get/tapes", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "page": "$page",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  getTape(tapeID) async {
    try {
      response = await dio.post("/get/tape", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "tapeID": "$tapeID",
      });
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  ProgressBar _sendingMsgProgressBar;

  addTape(_path, title, description, context) async {
    _sendingMsgProgressBar = ProgressBar();
    var p;

    try {
      FormData formData = FormData.fromMap({
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "file": await MultipartFile.fromFile(_path),
        "title": "$title",
        "description": "$description"
      });

      print(
          "Adding tape with data ${formData.files[0].value.length}\n    FIEDLS ${formData.fields}");

      _sendingMsgProgressBar.show(context, "$p");

      response = await dio.post(
        "/tape/add",
        data: formData,
        onSendProgress: (int sent, int total) {
          String percent = (sent / total * 100).toStringAsFixed(2);
          print("$percent% $total");
        },
      );

      print("Getting response from TAPE upload ${response.data}");
      _sendingMsgProgressBar.hide();
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
      print("Error when upload TAPE: ${e.response.data}");
      _sendingMsgProgressBar.hide();
      return e.response.data;
    }
  }

  uploadAvatar(_path) async {
    try {
      FormData formData = FormData.fromMap({
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "file": await MultipartFile.fromFile(_path),
      });

      print("Uploading avatar with data ${formData.fields}");

      response = await dio.post("/avatar/upload", data: formData);
      print("Getting response from avatar upload ${response.data}");

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }

  uploadMedia(_path, type) async {
    try {
      FormData formData = FormData.fromMap({
        "user_id": "${user.id}",
        "userToken": "${user.unique}",
        "file": await MultipartFile.fromFile(_path),
        "type": type
      });

      print("Uploading media with data ${formData.fields}");

      response = await dio.post("$mediaChat", data: formData);
      print("Getting response from media upload ${response.data}");

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response);
      } else {
        print("ERROR $e");
        print(e.request.data);
        print(e.message);
      }
      return e.response.data;
    }
  }

  addCommentToTape(String comment, String tapeID) async {
    try {
      response = await dio.post("/tape/comment/add", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "comment": "$comment",
        "tapeID": "$tapeID",
      });
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }

  blockUser(String userId) async {
    try {
      response = await dio.post("/block/user", data: {
        "customerID": "${user.id}",
        "unique": "${user.unique}",
        "blockedID": "$userId",
      });
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        return e.response.data;
      } else {
        print(response.statusCode);
        print(e.response.statusCode);
      }
    }
  }
}
