// import 'package:flutter/material.dart';
// import 'package:indigo24/pages/payments_history.dart';
// import 'package:indigo24/pages/transfer_history.dart';
// import 'package:indigo24/services/api.dart';
// import 'package:polygon_clipper/polygon_border.dart';
// import '../style/fonts.dart';

// class WalletTab extends StatefulWidget {
//   @override
//   _WalletTabState createState() => _WalletTabState();
// }

// class _WalletTabState extends State<WalletTab> {
//   double _amount;
//   double _blockedAmount = 1231535115.12421;
//   String _symbol;
//   double _realAmount = 397.23;
//   double _tengeCoef = 1;
//   double _euroCoef  = 0;
//   double _rubleCoef  = 0;
//   double _dollarCoef = 0;

//   var api = Api();

//   @override
//   void initState() {
//     _symbol = '₸';
//     _amount = _realAmount;
//     api.getExchangeRate().then((v) {
//       var ex = v["exchangeRates"];
//       print(ex);
//       print('ex $ex');
//       _euroCoef = double.parse(ex['EUR']);
//       _rubleCoef = double.parse(ex['RUB']);
//       _dollarCoef = double.parse(ex['USD']);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         body: Stack(
//           children: <Widget>[
//             Image.asset(
//               'assets/images/walletBackground.png',
//               fit: BoxFit.fill,
//             ),
//             Column(
//               children: <Widget>[
//                 SizedBox(height: 10),
//                 Text('Кошелек', style: fS26(c: 'ffffff')),
//                 _devider(),
//                 _balance(),
//                 SizedBox(height: 10),
//                 _balanceAmount(),
//                 _exchangeButtons(),
//                 _blockedBalance(size),
//                 SizedBox(height: 20),
//                 _payInOut(size),
//                 SizedBox(height: 20),
//                 _payments(size),
//                 SizedBox(height: 20),
//                 _transfer(size),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ButtonTheme _transfer(Size size) {
//     return ButtonTheme(
//       minWidth: size.width * 0.8,
//       height: 70,
//       child: RaisedButton(
//         onPressed: () {
//           print('transfer is pressed');
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TransferHistoryPage()),
//           );
//         },
//         child: Container(
//           width: size.width * 0.72,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Image(
//                 image: AssetImage("assets/images/transfers.png"),
//                 height: 40,
//               ),
//               Text(
//                 'Переводы',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//               ),
//               Container(width: 10),
//             ],
//           ),
//         ),
//         color: Color(0xFFFFFFFF),
//         textColor: Color(0xFF001D52),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//             10.0,
//           ),
//         ),
//       ),
//     );
//   }

//   ButtonTheme _payments(Size size) {
//     return ButtonTheme(
//       minWidth: size.width * 0.8,
//       height: 70,
//       child: RaisedButton(
//         onPressed: () {
//           print('payments is pressed');
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => PaymentHistoryPage()),
//           );
//         },
//         child: Container(
//           width: size.width * 0.72,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Image(
//                 image: AssetImage("assets/images/payments.png"),
//                 height: 40,
//               ),
//               Text(
//                 'Платежи',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//               ),
//               Container(width: 10),
//             ],
//           ),
//         ),
//         color: Color(0xFFFFFFFF),
//         textColor: Color(0xFF001D52),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(
//             10.0,
//           ),
//         ),
//       ),
//     );
//   }

//   Container _devider() {
//     return Container(
//       height: 0.6,
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       color: Color(0xFFD1E1FF),
//     );
//   }

//   Text _balance() {
//     return Text(
//       'Баланс',
//       style: fS18(c: 'ffffff'),
//     );
//   }

//   Text _balanceAmount() {
//     return Text(
//       '$_amount $_symbol',
//       style: fS26(c: 'ffffff'),
//     );
//   }

//   Container _blockedBalance(Size size) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       color: Color(0xFF0543B8),
//       width: size.width,
//       child: Column(
//         children: <Widget>[
//           Text('Баланс в обработке', style: fS18w200(c: 'ffffff')),
//           Container(height: 5),
//           Text('$_blockedAmount ₸', style: fS26w200(c: 'ffffff')),
//         ],
//       ),
//     );
//   }

//   Row _payInOut(Size size) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         ButtonTheme(
//           minWidth: size.width * 0.35,
//           height: 50,
//           child: RaisedButton(
//             onPressed: () {
//               print('пополнить is pressed');
//             },
//             child: const Text(
//               'ПОПОЛНИТЬ',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             color: Color(0xFFFFFFFF),
//             textColor: Color(0xFF0543B8),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 10.0,
//               ),
//             ),
//           ),
//         ),
//         ButtonTheme(
//           minWidth: size.width * 0.35,
//           height: 50,
//           child: RaisedButton(
//             onPressed: () {
//               print('вывести is pressed');
//             },
//             child: Text(
//               'ВЫВЕСТИ',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             color: Color(0xFFFFFFFF),
//             textColor: Color(0xFF0543B8),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 10.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Row _exchangeButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         GestureDetector(
//           child: Container(
//             padding: EdgeInsets.all(15.0),
//             decoration: ShapeDecoration(
//               color: Color(0xFF1C4D9B),
//               shape: PolygonBorder(
//                 sides: 8,
//                 borderRadius: 8.0,
//                 border: BorderSide(
//                   color: Color(0xFF4E74B1),
//                   width: 3,
//                 ),
//               ),
//             ),
//             child: Text(
//               '₸',
//               style: fS20(c: 'FFFFFF'),
//             ),
//           ),
//           onTap: () {
//             setState(() {
//               _amount = _realAmount / _tengeCoef;
//               _amount = num.parse(_amount.toStringAsFixed(3));
//               _symbol = '₸';
//             });
//           },
//         ),
//         GestureDetector(
//           child: Container(
//             padding: EdgeInsets.all(15.0),
//             decoration: ShapeDecoration(
//               color: Color(0xFF1C4D9B),
//               shape: PolygonBorder(
//                 sides: 8,
//                 borderRadius: 8.0,
//                 border: BorderSide(
//                   color: Color(0xFF4E74B1),
//                   width: 3,
//                 ),
//               ),
//             ),
//             child: Text(
//               '₽',
//               style: fS20(c: 'FFFFFF'),
//             ),
//           ),
//           onTap: () {
//             setState(() {
//               _amount = _realAmount / _rubleCoef;
//               _amount = num.parse(_amount.toStringAsFixed(3));
//               _symbol = '₽';
//             });
//           },
//         ),
//         GestureDetector(
//           child: Container(
//             padding: EdgeInsets.all(15.0),
//             decoration: ShapeDecoration(
//               color: Color(0xFF1C4D9B),
//               shape: PolygonBorder(
//                 sides: 8,
//                 borderRadius: 8.0,
//                 border: BorderSide(
//                   color: Color(0xFF4E74B1),
//                   width: 3,
//                 ),
//               ),
//             ),
//             child: Text(
//               '\$',
//               style: fS20(c: 'FFFFFF'),
//             ),
//           ),
//           onTap: () {
//             setState(() {
//               _amount = _realAmount / _dollarCoef;
//               _amount = num.parse(_amount.toStringAsFixed(3));
//               _symbol = '\$';
//             });
//           },
//         ),
//         GestureDetector(
//           child: Container(
//             padding: EdgeInsets.all(15.0),
//             decoration: ShapeDecoration(
//               color: Color(0xFF1C4D9B),
//               shape: PolygonBorder(
//                 sides: 8,
//                 borderRadius: 8.0,
//                 border: BorderSide(
//                   color: Color(0xFF4E74B1),
//                   width: 3,
//                 ),
//               ),
//             ),
//             child: Text(
//               '€',
//               style: fS20(c: 'FFFFFF'),
//             ),
//           ),
//           onTap: () {
//             setState(() {
//               _amount = _realAmount / _euroCoef;
//               _amount = num.parse(_amount.toStringAsFixed(3));
//               _symbol = '€';
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
