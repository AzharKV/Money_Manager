import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/constFiles/dateConvert.dart';
import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/controller/reportController.dart';
import 'package:day_manager/controller/transactionController.dart';
import 'package:day_manager/controller/transDetailController.dart';
import 'package:day_manager/model/transactionModel.dart';
import 'package:day_manager/view/transactionDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    TransDetailController transactionDetailController =
        Provider.of<TransDetailController>(context);
    ReportController reportController = Provider.of<ReportController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Day Manager", style: TextStyle(color: primaryColor)),
        centerTitle: true,
        backwardsCompatibility: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: transactionController.transactionList.length == 0
          ? Center(child: Text("No Records"))
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: transactionController.transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                TransactionModel? data =
                    transactionController.transactionList[index];

                String amountSign = data!.isIncome == 1 ? "+" : "-";
                Color amountColor =
                    data.isIncome == 1 ? incomeGreen : expenseRed;

                return ListTile(
                  onTap: () {
                    transactionDetailController.toTransactionDetail(
                        isSaved: true,
                        id: data.id,
                        title: data.title,
                        description: data.description,
                        amount: data.amount,
                        department: data.category,
                        isIncome: data.isIncome == 1 ? true : false,
                        dateTime: data.dateTime);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TransactionDetail()));
                  },
                  title: Text(data.title ?? ""),
                  contentPadding: EdgeInsets.all(5.0),
                  leading: Container(
                    height: 50.0,
                    width: 50.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [BoxShadow(color: blackColor)],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: SvgPicture.asset(
                      transactionController.tileIcon(data.category ?? others),
                      height: 35.0,
                      color: svgColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dateConverter(DateTime.parse(
                          data.dateTime ?? "2000-01-1 00:00:00.000"))),
                      Text(
                        "$amountSign${data.amount}",
                        style: TextStyle(color: amountColor),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      transactionController.deleteTransaction(data.id ?? 0);
                      transactionController.fetchTransaction();
                      reportController.fetchTransaction();
                    },
                    icon: Icon(Icons.delete_outline, color: svgColor),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
    );
  }
}
