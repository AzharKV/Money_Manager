import 'package:day_manager/components/recentTransList.dart';
import 'package:day_manager/components/homeReportContainer.dart';
import 'package:day_manager/components/userProfileCard.dart';
import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/controller/transactionController.dart';
import 'package:day_manager/controller/transDetailController.dart';
import 'package:day_manager/customWidgets/textButton.dart';
import 'package:day_manager/view/transactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    TransDetailController transactionDetailController =
        Provider.of<TransDetailController>(context);

    return transactionController.fetching
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              //userData
              UserProfileCard(),
              //balance container
              HomeReportContainer(transactionController: transactionController),
              //recent transactions title
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
              //transaction List View
              RecentTransList(
                  transController: transactionController,
                  transDetailController: transactionDetailController),
            ],
          );
  }
}
