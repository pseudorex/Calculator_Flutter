import 'package:flutter/material.dart';

class ModernCalculator extends StatefulWidget {
  const ModernCalculator({super.key});

  @override
  State<ModernCalculator> createState() => _ModernCalculatorState();
}

class _ModernCalculatorState extends State<ModernCalculator> {
  String input = '';
  String output = '0';
  String operation = '';
  double firstNumber = 0;
  bool shouldResetInput = false;

  void onButtonPress(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '0';
        operation = '';
        firstNumber = 0;
        shouldResetInput = false;
      } else if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        if (input.isNotEmpty) {
          firstNumber = double.tryParse(input) ?? 0;
          operation = value;
          shouldResetInput = true;
        }
      } else if (value == '=') {
        if (operation.isNotEmpty && input.isNotEmpty) {
          double secondNumber = double.tryParse(input) ?? 0;
          double result = 0;
          switch (operation) {
            case '+':
              result = firstNumber + secondNumber;
              break;
            case '-':
              result = firstNumber - secondNumber;
              break;
            case '×':
              result = firstNumber * secondNumber;
              break;
            case '÷':
              result = secondNumber != 0 ? firstNumber / secondNumber : double.infinity;
              break;
          }
          output = result.isInfinite ? 'Error' : removeTrailingZero(result);
          input = output;
          operation = '';
          shouldResetInput = true;
        }
      } else {
        if (shouldResetInput) {
          input = '';
          shouldResetInput = false;
        }
        input += value;
      }
    });
  }

  String removeTrailingZero(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/calc_icon.png'),
        ),
        title: const Text("Modern Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Text(
                  output,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Buttons
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      buildButton('C', Colors.redAccent),
                      buildButton('×', Colors.grey),
                      buildButton('÷', Colors.blue),
                      buildButton('⌫', Colors.blue),
                      buildButton('7', Colors.black),
                      buildButton('8', Colors.black),
                      buildButton('9', Colors.black),
                      buildButton('-', Colors.blue),
                      buildButton('4', Colors.black),
                      buildButton('5', Colors.black),
                      buildButton('6', Colors.black),
                      buildButton('+', Colors.blue),
                      buildButton('1', Colors.black),
                      buildButton('2', Colors.black),
                      buildButton('3', Colors.black),
                      buildButton('=', Colors.orange),
                      buildButton('.', Colors.black),
                      buildButton('0', Colors.black),
                      buildButton('00', Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () => onButtonPress(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(color: color, width: 1.5),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
