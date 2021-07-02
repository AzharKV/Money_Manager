import 'package:day_manager/constFiles/strings.dart';
import 'package:day_manager/services/databaseHelper.dart';
import 'package:flutter/cupertino.dart';

class TransDetailController with ChangeNotifier {
  DatabaseHelper? databaseHelper = DatabaseHelper.instance;

  TextEditingController titleField = TextEditingController();
  TextEditingController amountField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();

  bool isIncomeSelected = false;
  bool savedTransaction = false;

  String selectedDepartment = others;

  int? transactionId;
  String? date;

  bool buttonSelected = true;

  void changeHomeNdReportSection(bool value) {
    buttonSelected = value;
    notifyListeners();
  }

  void changeCategory() {
    isIncomeSelected = !isIncomeSelected;
    notifyListeners();
  }

  void changeDepartment(String name) {
    selectedDepartment = name;
    notifyListeners();
  }

  String titleIcon() {
    if (selectedDepartment == health) return svgPath(healthSvg);
    if (selectedDepartment == family) return svgPath(familySvg);
    if (selectedDepartment == shopping) return svgPath(shoppingSvg);
    if (selectedDepartment == food) return svgPath(foodSvg);
    if (selectedDepartment == vehicle) return svgPath(vehicleSvg);
    if (selectedDepartment == salon) return svgPath(salonSvg);
    if (selectedDepartment == devices) return svgPath(devicesSvg);
    if (selectedDepartment == office) return svgPath(officeSvg);
    return svgPath(othersSvg);
  }

  void toTransactionDetail({
    required bool isSaved,
    int? id,
    String? title,
    String? description,
    String? amount,
    bool? isIncome,
    String? department,
    String? dateTime,
  }) {
    savedTransaction = isSaved;
    transactionId = id;
    titleField.text = title ?? "";
    descriptionField.text = description ?? "";
    amountField.text = amount ?? "";
    isIncomeSelected = isIncome ?? false;
    selectedDepartment = department ?? others;
    date = dateTime ?? DateTime.now().toString();
    notifyListeners();
  }
}
