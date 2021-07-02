import 'package:day_manager/constFiles/colors.dart';
import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/controller/reportController.dart';
import 'package:day_manager/controller/transDetailController.dart';
import 'package:day_manager/controller/transactionController.dart';
import 'package:day_manager/customWidgets/snackbar.dart';
import 'package:day_manager/model/transactionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransactionDetail extends StatelessWidget {
  TransactionDetail({Key? key}) : super(key: key);
  static TransDetailController? transDetailController;
  static TransactionController? transController;
  static ReportController? reportController;

  @override
  Widget build(BuildContext context) {
    transDetailController = Provider.of<TransDetailController>(context);
    transController = Provider.of<TransactionController>(context);
    reportController = Provider.of<ReportController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        leadingWidth: 25.0,
        title: Row(
          children: [
            Text(
              transDetailController!.isIncomeSelected ? income : expense,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(Icons.refresh_outlined),
                tooltip: "Change Category",
                onPressed: () => transDetailController!.changeCategory())
          ],
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: TextButton(
                    onPressed: () => save(context),
                    child: Text(
                        transDetailController!.savedTransaction
                            ? "Update"
                            : "Save",
                        style: TextStyle(color: whiteColor))),
              ),
            ],
          )
        ],
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Column(
        children: [
          GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.4),
            children: [
              categoryIcons(
                  text: health,
                  svgName: healthSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == health
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(health)),
              categoryIcons(
                  text: family,
                  svgName: familySvg,
                  isSelected:
                      transDetailController!.selectedDepartment == family
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(family)),
              categoryIcons(
                  text: shopping,
                  svgName: shoppingSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == shopping
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(shopping)),
              categoryIcons(
                  text: food,
                  svgName: foodSvg,
                  isSelected: transDetailController!.selectedDepartment == food
                      ? true
                      : false,
                  onPress: () => transDetailController!.changeDepartment(food)),
              categoryIcons(
                  text: vehicle,
                  svgName: vehicleSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == vehicle
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(vehicle)),
              categoryIcons(
                  text: salon,
                  svgName: salonSvg,
                  isSelected: transDetailController!.selectedDepartment == salon
                      ? true
                      : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(salon)),
              categoryIcons(
                  text: devices,
                  svgName: devicesSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == devices
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(devices)),
              categoryIcons(
                  text: office,
                  svgName: officeSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == office
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(office)),
              categoryIcons(
                  text: others,
                  svgName: othersSvg,
                  isSelected:
                      transDetailController!.selectedDepartment == others
                          ? true
                          : false,
                  onPress: () =>
                      transDetailController!.changeDepartment(others)),
            ],
          ),
          Container(
            color: primaryColor,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: TextField(
                      controller: transDetailController!.titleField,
                      cursorColor: greyText,
                      style: TextStyle(
                          color: greyText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(color: greyText),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 5.0),
                            child: SvgPicture.asset(
                              transDetailController!.titleIcon(),
                              height: 5.0,
                              color: whiteColor,
                            ),
                          ),
                          border: InputBorder.none),
                    )),
                Spacer(),
                Expanded(
                    flex: 2,
                    child: TextField(
                      controller: transDetailController!.amountField,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      cursorColor: greyText,
                      style: TextStyle(
                          color: greyText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(color: greyText),
                          border: InputBorder.none),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: transDetailController!.descriptionField,
                textAlign: TextAlign.start,
                minLines: 20,
                maxLines: 50,
                decoration: InputDecoration(
                    hintText: "Description here...", border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding categoryIcons({
    required String text,
    required String svgName,
    required bool isSelected,
    required Function() onPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: isSelected ? Color(0xffeae1f9) : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  svgPath(svgName),
                  height: 35.0,
                  color: svgColor,
                ),
              ),
              Text(
                text,
                style: TextStyle(color: svgColor, fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  save(BuildContext context) {
    if (transDetailController!.titleField.text.isEmpty) {
      snackBar(context: context, title: "Title Is Mandatory");
    } else if (double.tryParse(transDetailController!.amountField.text) ==
            null ||
        transDetailController!.amountField.text.contains("-")) {
      snackBar(context: context, title: "Enter Valid Amount");
    } else {
      TransactionModel transactionModel = TransactionModel(
        id: transDetailController!.savedTransaction
            ? transDetailController!.transactionId
            : DateTime.now().microsecondsSinceEpoch,
        title: transDetailController!.titleField.text,
        description: transDetailController!.descriptionField.text,
        amount: transDetailController!.amountField.text,
        isIncome: transDetailController!.isIncomeSelected ? 1 : 0,
        category: transDetailController!.selectedDepartment,
        dateTime: transDetailController!.savedTransaction
            ? transDetailController!.date
            : DateTime.now().toString(),
      );

      if (transDetailController!.savedTransaction) {
        transController!.updateTransaction(transactionModel);
      } else {
        transController!.insertTransaction(transactionModel);
      }
      transController!.fetchTransaction();
      reportController!.fetchTransaction();
      Navigator.pop(context);
    }
  }
}
