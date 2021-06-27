import 'package:flutter/material.dart';
import 'package:flutter_calculator/buttonLayout.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String answer = "";
  final List<String> button = [
    'C',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        input,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CalButton(
                        text: button[index],
                        onPressed: () {
                          setState(() {
                            input = "";
                            answer = "";
                          });
                        },
                      );
                    }
                    if (index == 1) {
                      return CalButton(
                        text: button[index],
                        onPressed: () {
                          equalAll();
                        },
                      );
                    }
                    if (index == 2) {
                      return CalButton(
                        text: button[index],
                        onPressed: () {
                          setState(() {
                            input = input.substring(0, input.length - 1);
                          });
                        },
                      );
                    }
                    if (index == 17) {
                      return CalButton(
                        text: button[index],
                        onPressed: () {
                          equalAll();
                        },
                      );
                    }
                    return CalButton(
                      text: button[index],
                      onPressed: () {
                        setState(() {
                          input += button[index];
                        });
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  equalAll() {
    final expression = input;
    String finalVal = expression.replaceAll('x', '*');

    Parser parser = Parser();
    Expression exp = parser.parse(finalVal);
    ContextModel contextModel = ContextModel();

    double totalEvl = exp.evaluate(EvaluationType.REAL, contextModel);
    setState(() {
      answer = totalEvl.toStringAsFixed(2);
    });
  }
}
