import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      title: 'Calculator',
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";

  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = "0";
        result = '0';
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton({buttonColor, buttonHeight, buttonText}) {
    return Container(
      height: MediaQuery.of(context).size.height * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.all(16.0),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            )),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(equation, style: TextStyle(fontSize: 36.0)),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(result, style: TextStyle(fontSize: 40.0)),
        ),
        Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton(
                      buttonText: 'C',
                      buttonHeight: 0.1,
                      buttonColor: Colors.red,
                    ),
                    buildButton(
                      buttonText: '⌫',
                      buttonHeight: 0.1,
                      buttonColor: Colors.blueAccent,
                    ),
                    buildButton(
                      buttonText: '÷',
                      buttonHeight: 0.1,
                      buttonColor: Colors.blueAccent,
                    ),
                  ]),
                  TableRow(children: [
                    buildButton(
                      buttonText: '1',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '2',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '3',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                  ]),
                  TableRow(children: [
                    buildButton(
                      buttonText: '4',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '5',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '6',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                  ]),
                  TableRow(children: [
                    buildButton(
                      buttonText: '7',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '8',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '9',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                  ]),
                  TableRow(children: [
                    buildButton(
                      buttonText: '.',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '0',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                    buildButton(
                      buttonText: '00',
                      buttonHeight: 0.1,
                      buttonColor: Colors.black54,
                    ),
                  ]),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton(
                        buttonText: '×',
                        buttonHeight: 0.1,
                        buttonColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton(
                        buttonText: '-',
                        buttonHeight: 0.1,
                        buttonColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton(
                        buttonText: '+',
                        buttonHeight: 0.1,
                        buttonColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton(
                        buttonText: '=',
                        buttonHeight: 0.2,
                        buttonColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
