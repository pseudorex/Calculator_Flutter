import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';
  String operation = '';
  double firstNumber = 0;

  void onButtonPress(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
        operation = '';
        firstNumber = 0;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        firstNumber = double.tryParse(input) ?? 0;
        operation = value;
        input = '';
      } else if (value == '=') {
        double secondNumber = double.tryParse(input) ?? 0;
        if (operation == '+') {
          result = (firstNumber + secondNumber).toString();
        } else if (operation == '-') {
          result = (firstNumber - secondNumber).toString();
        } else if (operation == '*') {
          result = (firstNumber * secondNumber).toString();
        } else if (operation == '/') {
          result = secondNumber != 0 ? (firstNumber / secondNumber).toString() : 'Error';
        }
        input = '';
        operation = '';
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Optional padding for alignment
          child: Image.asset('assets/images/calc_icon.png'),
        ),
        title: const Text("Basic Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                input.isEmpty ? result : input,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('/'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('*'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('C'),
                  buildButton('0'),
                  buildButton('='),
                  buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String label) {
    return ElevatedButton(
      onPressed: () => onButtonPress(label),
      child: Text(label, style: const TextStyle(fontSize: 30)),
    );
  }
}