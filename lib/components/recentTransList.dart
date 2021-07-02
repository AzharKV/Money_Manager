import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/constFiles/dateConvert.dart';
import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/controller/transDetailController.dart';
import 'package:day_manager/controller/transactionController.dart';
import 'package:day_manager/model/transactionModel.dart';
import 'package:day_manager/view/transactionDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentTransList extends StatelessWidget {
  const RecentTransList({
    Key? key,
    required this.transController,
    required this.transDetailController,
  }) : super(key: key);

  final TransactionController transController;
  final TransDetailController transDetailController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transController.transactionList.length == 0
          ? Center(child: Text("No Records"))
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                if (transController.transactionList.length > index) {
                  TransactionModel? data =
                      transController.transactionList[index];

                  String amountSign = data!.isIncome == 1 ? "+" : "-";
                  Color amountColor =
                      data.isIncome == 1 ? incomeGreen : expenseRed;

                  return ListTile(
                    onTap: () {
                      transDetailController.toTransactionDetail(
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
                                TransactionDetail()),
                      );
                    },
                    title: Text(data.title ?? ""),
                    contentPadding: EdgeInsets.all(10.0),
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [BoxShadow(color: blackColor)],
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: SvgPicture.asset(
                        transController.tileIcon(data.category ?? others),
                        height: 35.0,
                        color: svgColor,
                      ),
                    ),
                    subtitle: Text(dateConverter(DateTime.parse(
                        data.dateTime ?? "2000-01-1 00:00:00.000"))),
                    trailing: Text(
                      "$amountSign${data.amount}",
                      style: TextStyle(color: amountColor),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
    );
  }
}
