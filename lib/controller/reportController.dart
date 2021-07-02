import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/model/transactionModel.dart';
import 'package:day_manager/services/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportController with ChangeNotifier {
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;
  ReportController() {
    if (databaseHelper != null) fetchTransaction();
  }

  String reportMethod = incomeReport;

  List<TransactionModel?> transactionList = [];
  List<TransactionModel?> transactionIncomeList = [];
  List<TransactionModel?> transactionExpenseList = [];
  double total = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double healthIncomeAmount = 0.0;
  double healthExpenseAmount = 0.0;
  double familyIncomeAmount = 0.0;
  double familyExpenseAmount = 0.0;
  double shoppingIncomeAmount = 0.0;
  double shoppingExpenseAmount = 0.0;
  double foodIncomeAmount = 0.0;
  double foodExpenseAmount = 0.0;
  double vehicleIncomeAmount = 0.0;
  double vehicleExpenseAmount = 0.0;
  double salonIncomeAmount = 0.0;
  double salonExpenseAmount = 0.0;
  double deviceIncomeAmount = 0.0;
  double deviceExpenseAmount = 0.0;
  double officeIncomeAmount = 0.0;
  double officeExpenseAmount = 0.0;
  double othersIncomeAmount = 0.0;
  double othersExpenseAmount = 0.0;

  void cartButton(String value) {
    reportMethod = value;
    notifyListeners();
  }

  void fetchTransaction({
    DateTime? customFromDate,
    DateTime? customToDate,
  }) async {
    DateTime fromDate = customFromDate ?? DateTime.now();
    DateTime toDate = customFromDate ?? DateTime.now();

    transactionList = [];

    String fromDayPattern = 'd';
    String fromMonthPattern = 'M';

    String toDayPattern = 'd';
    String toMonthPattern = 'M';

    if (fromDate.day < 10) fromDayPattern = '0d';
    if (fromDate.month < 10) fromMonthPattern = '0M';
    if (toDate.day < 10) fromDayPattern = '0d';
    if (toDate.month < 10) fromMonthPattern = '0M';

    String fromDateFormat = "y-$fromMonthPattern-$fromDayPattern";
    String toDateFormat = "y-$toMonthPattern-$toDayPattern";

    final dataList = await databaseHelper!.getDateRangeData(
        transactionTable,
        DateFormat(fromDateFormat).format(fromDate),
        DateFormat(toDateFormat).format(toDate));

    transactionList = dataList.map((e) => TransactionModel.fromMap(e)).toList();

    transactionIncomeList =
        transactionList.where((element) => element!.isIncome == 1).toList();
    transactionExpenseList =
        transactionList.where((element) => element!.isIncome == 0).toList();

    totalIncome = transactionIncomeList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element!.amount ?? "0.0"));

    totalExpense = transactionExpenseList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element!.amount ?? "0.0"));

    total = totalIncome - totalExpense;

    healthIncomeAmount = amountCalc(transactionIncomeList, health);
    healthExpenseAmount = amountCalc(transactionExpenseList, health);
    familyIncomeAmount = amountCalc(transactionIncomeList, family);
    familyExpenseAmount = amountCalc(transactionExpenseList, family);
    shoppingIncomeAmount = amountCalc(transactionIncomeList, shopping);
    shoppingExpenseAmount = amountCalc(transactionExpenseList, shopping);
    foodIncomeAmount = amountCalc(transactionIncomeList, food);
    foodExpenseAmount = amountCalc(transactionExpenseList, food);
    vehicleIncomeAmount = amountCalc(transactionIncomeList, vehicle);
    vehicleExpenseAmount = amountCalc(transactionExpenseList, vehicle);
    salonIncomeAmount = amountCalc(transactionIncomeList, salon);
    salonExpenseAmount = amountCalc(transactionExpenseList, salon);
    deviceIncomeAmount = amountCalc(transactionIncomeList, devices);
    deviceExpenseAmount = amountCalc(transactionExpenseList, devices);
    officeIncomeAmount = amountCalc(transactionIncomeList, office);
    officeExpenseAmount = amountCalc(transactionExpenseList, office);
    othersIncomeAmount = amountCalc(transactionIncomeList, others);
    othersExpenseAmount = amountCalc(transactionExpenseList, others);

    notifyListeners();
  }

  double amountCalc(
          List<TransactionModel?> transactionIncomeList, String department) =>
      transactionIncomeList
          .where((element) => element!.category == department)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + double.parse(element!.amount ?? "0.0"));
}
