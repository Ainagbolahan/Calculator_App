import 'package:flutter/cupertino.dart';

class ButtonPressed extends ChangeNotifier {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      equation = "0";
      result = "0";
      equationFontSize = 38.0;
      resultFontSize = 48.0;
    } else if (buttonText == "⌫") {
      equationFontSize = 38.0;
      resultFontSize = 48.0;
      equation = equation.substring(0, equation.length - 1);
      if (equation == "") {
        equation = "0";
      }
    } else if (buttonText == "=") {
      equationFontSize = 38.0;
      resultFontSize = 48.0;
    } else {
      equationFontSize = 38.0;
      resultFontSize = 48.0;
      if (equation == 0) {
        equation = buttonText;
      } else {
        equation += buttonText;
      }
    }
    notifyListeners();
  }
}
