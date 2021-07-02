import 'package:day_manager/components/categorySelectHeader.dart';
import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/controller/reportController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);
  static ReportController? reportController;

  @override
  Widget build(BuildContext context) {
    reportController = Provider.of<ReportController>(context);

    return Column(
      children: [
        //category selector
        CategorySelectHeader(),

        //pie chart, if not full report
        if (reportController!.reportMethod != fullReport)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: PieChart(
              dataMap: {
                health: chartValue(reportController!.healthIncomeAmount,
                    reportController!.healthExpenseAmount),
                family: chartValue(reportController!.familyIncomeAmount,
                    reportController!.familyExpenseAmount),
                shopping: chartValue(reportController!.shoppingIncomeAmount,
                    reportController!.shoppingExpenseAmount),
                food: chartValue(reportController!.foodIncomeAmount,
                    reportController!.foodExpenseAmount),
                vehicle: chartValue(reportController!.vehicleIncomeAmount,
                    reportController!.vehicleExpenseAmount),
                salon: chartValue(reportController!.salonIncomeAmount,
                    reportController!.salonExpenseAmount),
                devices: chartValue(reportController!.deviceIncomeAmount,
                    reportController!.deviceExpenseAmount),
                office: chartValue(reportController!.officeIncomeAmount,
                    reportController!.officeExpenseAmount),
                others: chartValue(reportController!.othersIncomeAmount,
                    reportController!.othersExpenseAmount),
              },
              animationDuration: Duration(seconds: 1),
              ringStrokeWidth: 40,
              chartType: ChartType.ring,
              legendOptions: LegendOptions(showLegends: true),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
          ),

        //balance container, if full report
        if (reportController!.reportMethod == fullReport)
          Container(
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.85),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(
              children: [
                Text("Balance: ${reportController!.total.toStringAsFixed(1)}",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: whiteColor)),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Income:\n${reportController!.totalIncome.toStringAsFixed(1)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: whiteColor)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          "Expense:\n${reportController!.totalExpense.toStringAsFixed(1)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: whiteColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),

        //category list
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              tile(
                title: "Health",
                svgName: healthSvg,
                incomeAmount: reportController!.healthIncomeAmount,
                expenseAmount: reportController!.healthExpenseAmount,
              ),
              tile(
                title: "Family",
                svgName: familySvg,
                incomeAmount: reportController!.familyIncomeAmount,
                expenseAmount: reportController!.familyExpenseAmount,
              ),
              tile(
                title: "Shopping",
                svgName: shoppingSvg,
                incomeAmount: reportController!.shoppingIncomeAmount,
                expenseAmount: reportController!.shoppingExpenseAmount,
              ),
              tile(
                title: "Food",
                svgName: foodSvg,
                incomeAmount: reportController!.foodIncomeAmount,
                expenseAmount: reportController!.foodExpenseAmount,
              ),
              tile(
                title: "Vehicle",
                svgName: vehicleSvg,
                incomeAmount: reportController!.vehicleIncomeAmount,
                expenseAmount: reportController!.vehicleExpenseAmount,
              ),
              tile(
                title: "Salon",
                svgName: salonSvg,
                incomeAmount: reportController!.salonIncomeAmount,
                expenseAmount: reportController!.salonExpenseAmount,
              ),
              tile(
                title: "Devices",
                svgName: devicesSvg,
                incomeAmount: reportController!.deviceIncomeAmount,
                expenseAmount: reportController!.deviceExpenseAmount,
              ),
              tile(
                title: "Office",
                svgName: officeSvg,
                incomeAmount: reportController!.officeIncomeAmount,
                expenseAmount: reportController!.officeExpenseAmount,
              ),
              tile(
                title: "Others",
                svgName: othersSvg,
                incomeAmount: reportController!.othersIncomeAmount,
                expenseAmount: reportController!.othersExpenseAmount,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile tile({
    required String title,
    required String svgName,
    required double incomeAmount,
    required double expenseAmount,
  }) {
    double percentage = 0;
    String trailingAmount = "0.0";
    if (reportController!.reportMethod == income) {
      percentage = incomeAmount / reportController!.totalIncome * 100;
      if (incomeAmount != 0)
        trailingAmount = "+${incomeAmount.toStringAsFixed(1)}";
    }

    if (reportController!.reportMethod == expense) {
      percentage = expenseAmount / reportController!.totalExpense * 100;
      if (expenseAmount != 0)
        trailingAmount = "-${expenseAmount.toStringAsFixed(1)}";
    }

    if (reportController!.reportMethod == fullReport) {
      trailingAmount = (incomeAmount - expenseAmount).toStringAsFixed(1);
    }

    return ListTile(
      title: Text(title),
      contentPadding: EdgeInsets.all(10.0),
      leading: Container(
        height: 50.0,
        width: 50.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [BoxShadow(color: blackColor)],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: SvgPicture.asset(
          svgPath(svgName),
          height: 35.0,
          color: svgColor,
        ),
      ),
      subtitle: reportController!.reportMethod == fullReport
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$income: ${incomeAmount.toStringAsFixed(1)}",
                    style: TextStyle(color: incomeGreen)),
                Text("$expense: ${expenseAmount.toStringAsFixed(1)}",
                    style: TextStyle(color: expenseRed)),
              ],
            )
          : Text(
              "Percentage : ${percentage > 0 ? percentage.toStringAsFixed(1) : 0}%"),
      trailing: Text(trailingAmount,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: reportController!.reportMethod == income
                  ? incomeGreen
                  : reportController!.reportMethod == expense
                      ? expenseRed
                      : blackColor)),
    );
  }

  double chartValue(double incomeAmount, double expenseAmount) {
    if (reportController!.reportMethod == income) return incomeAmount;
    if (reportController!.reportMethod == expense) return expenseAmount;
    return incomeAmount - expenseAmount;
  }
}
