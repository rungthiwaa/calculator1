import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "0";
  String expression = "";

  buttonPressed(String value) {
    setState(() {
      if (value == "CLEAR") {
        result = "0";
      } else if (value == ".") {
        if (result.contains(".")) {
          return;
        } else {
          result = result + value;
        }
      } else if (value == "=") {
        expression = result.replaceAll("X", "*");

        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        result = "$calculate";
      } else {
        if (result == "0") {
          result = value;
        } else {
          result = result + value;
        }
      }
    });
  }

  Widget myButton(String buttonLabel) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonLabel),
        child: Text(buttonLabel,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculator By Aomam",
            style: TextStyle(
                fontSize: 25, color: Colors.pink, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                color: Color.fromARGB(255, 154, 192, 66),
                child: Text(
                  result,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Divider(),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      myButton("7"),
                      myButton("8"),
                      myButton("9"),
                      myButton("/"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("4"),
                      myButton("5"),
                      myButton("6"),
                      myButton("X"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("1"),
                      myButton("2"),
                      myButton("3"),
                      myButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("."),
                      myButton("0"),
                      myButton("00"),
                      myButton("+"),
                    ],
                  ),
                  Row(
                    children: [
                      myButton("CLEAR"),
                      myButton("="),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
