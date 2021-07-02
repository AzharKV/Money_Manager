import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/constFiles/dateConvert.dart';
import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/controller/transactionController.dart';
import 'package:day_manager/controller/transactionDetailController.dart';
import 'package:day_manager/customWidgets/buttons/textButton.dart';
import 'package:day_manager/model/transactionModel.dart';
import 'package:day_manager/view/transactionDetail.dart';
import 'package:day_manager/view/transactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static File? imageFile;

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    TransactionDetailController transactionDetailController =
        Provider.of<TransactionDetailController>(context);

    return transactionController.fetching
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              //userData

              Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: profileContainer,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: imageFile == null
                        ? Icon(Icons.person, size: 35, color: profileBG)
                        : Image.file(imageFile!, fit: BoxFit.contain),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back,",
                            style: TextStyle(
                                color: greyText, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Mohammed Azhar",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //balance card

              Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.85),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Total Balance",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("INR", style: TextStyle(color: textINRColor)),
                        Expanded(
                          child: AutoSizeText(
                              transactionController.total.toStringAsFixed(1),
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_downward,
                                        color: incomeGreen),
                                    Text(income,
                                        style: TextStyle(color: containerText)),
                                  ],
                                ),
                                Center(
                                  child: AutoSizeText(
                                    transactionController.totalIncome
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 20),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            color: containerText,
                            width: 2,
                            height: 50.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.arrow_upward, color: expenseRed),
                                    Text(expense,
                                        style: TextStyle(color: containerText)),
                                  ],
                                ),
                                Center(
                                  child: AutoSizeText(
                                    transactionController.totalExpense
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        color: whiteColor, fontSize: 20),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
                      .map((e) => Padding(
                          padding: EdgeInsets.only(top: 15.0), child: e))
                      .toList(),
                ),
              ),
              //recent transactions

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text("Recent transactions",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Expanded(
                    child: CustomTextButton(
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TransactionList())),
                      textStyle: TextStyle(
                          color: selectedTextButton,
                          fontWeight: FontWeight.bold),
                      text: 'See All',
                    ),
                  )
                ],
              ),
              //transactionListView

              Expanded(
                child: transactionController.transactionList.length == 0
                    ? Center(child: Text("No Records"))
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          if (transactionController.transactionList.length >
                              index) {
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
                              contentPadding: EdgeInsets.all(10.0),
                              leading: Container(
                                height: 50.0,
                                width: 50.0,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    boxShadow: [BoxShadow(color: blackColor)],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: SvgPicture.asset(
                                  transactionController
                                      .tileIcon(data.category ?? others),
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
                        }),
              ),
            ],
          );
  }
}
