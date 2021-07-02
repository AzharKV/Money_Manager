import 'controller/reportController.dart';
import 'controller/transactionController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constFiles/colors.dart';
import 'controller/transDetailController.dart';
import 'view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReportController()),
        ChangeNotifierProvider(create: (_) => TransactionController()),
        ChangeNotifierProvider(create: (_) => TransDetailController()),
      ],
      child: MaterialApp(
        title: 'Day Manager',
        theme: ThemeData(
            primaryColor: primaryColor, scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
