import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalresult = '0';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalresult = '0';
      opr = '';
      preOpr = '';
    } else if (btnText == '⌫') {
      if (result.isNotEmpty) {
        result = result.substring(0, result.length - 1);
        if (result.isEmpty) {
          result = '0';
        }
        finalresult = result;
      }
    } else if (btnText == '=') {
      if (opr.isNotEmpty && result.isNotEmpty) {
        numTwo = double.parse(result);
        if (opr == '+') {
          finalresult = add();
        } else if (opr == '-') {
          finalresult = sub();
        } else if (opr == 'x') {
          finalresult = mul();
        } else if (opr == '/') {
          finalresult = div();
        }
        preOpr = opr;
        // numOne = double.parse(finalresult);
        opr = '';
        result = '';
      }
    } else if (btnText == '%') {
      result = numOne / 100;
      finalresult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalresult = result;
    } else if (btnText == '+/-') {
      if (!result.toString().startsWith('-')) {
        result = '-' + result.toString();
      } else {
        result = result.toString().substring(1);
      }
      finalresult = result;
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
        if (opr == '+') {
          finalresult = add();
        } else if (opr == '-') {
          finalresult = sub();
        } else if (opr == 'x') {
          finalresult = mul();
        } else if (opr == '/') {
          finalresult = div();
        }
      }
      preOpr = opr;
      opr = btnText;
      result = '';
      finalresult = numOne.toString() + opr;
    } else {
      if (result == '0') {
        result = btnText;
      } else {
        result = result + btnText;
      }
      finalresult = result;
    }

    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) return "Error";
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (int.parse(splitDecimal[1]) == 0) return splitDecimal[0];
    }
    return result;
  }

  // Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btncolor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          text.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 50),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcbutton('AC', Colors.grey, Colors.black),
                      calcbutton('+/-', Colors.grey, Colors.black),
                      calcbutton('%', Colors.grey, Colors.black),
                      calcbutton('/', Colors.orange, Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcbutton('7', Colors.black, Colors.white),
                      calcbutton('8', Colors.black, Colors.white),
                      calcbutton('9', Colors.black, Colors.white),
                      calcbutton('x', Colors.orange, Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcbutton('4', Colors.black, Colors.white),
                      calcbutton('5', Colors.black, Colors.white),
                      calcbutton('6', Colors.black, Colors.white),
                      calcbutton('-', Colors.orange, Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcbutton('1', Colors.black, Colors.white),
                      calcbutton('2', Colors.black, Colors.white),
                      calcbutton('3', Colors.black, Colors.white),
                      calcbutton('+', Colors.orange, Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            calculation('0');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                          ),
                          child: const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      calcbutton('.', Colors.black, Colors.white),
                      calcbutton(
                          '⌫', Colors.red, Colors.white), // Delete Button
                      calcbutton('=', Colors.orange, Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
