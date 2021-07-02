import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/controller/homeController.dart';
import 'package:day_manager/controller/transactionDetailController.dart';
import 'package:day_manager/customWidgets/buttons/textButton.dart';
import 'package:day_manager/view/transactionDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homePage.dart';
import 'reportPage.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //read does not rebuild when changes
    //HomeController providerRead = Provider.of<HomeController>(context);
    //write rebuild when changes
    //HomeController providerWatch = Provider.of<HomeController>(context);

    HomeController homeController = Provider.of<HomeController>(context);
    TransactionDetailController transactionDetailController =
        Provider.of<TransactionDetailController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomTextButton(
                text: "Home",
                textColor: homeController.buttonSelected
                    ? selectedTextButton
                    : nonSelectedTextButton,
                splash: false,
                press: () {
                  if (!homeController.buttonSelected)
                    homeController.changeButton(true);
                },
              ),
              SizedBox(width: 10.0),
              CustomTextButton(
                text: "Report",
                textColor: homeController.buttonSelected
                    ? nonSelectedTextButton
                    : selectedTextButton,
                splash: false,
                press: () {
                  if (homeController.buttonSelected)
                    homeController.changeButton(false);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          transactionDetailController.toTransactionDetail(isSaved: false);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TransactionDetail()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
          child: homeController.buttonSelected ? HomePage() : ReportPage(),
        ),
      ),
    );
  }
}
