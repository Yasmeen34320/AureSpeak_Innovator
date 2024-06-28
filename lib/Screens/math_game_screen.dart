import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:lottie/lottie.dart';

class MathGameScreen extends StatefulWidget {
  final String? lang1;
  MathGameScreen({super.key, required this.lang1});
  @override
  _MathGameScreenState createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  final Random _random = Random();
  int _number1 = 0;
  int _number2 = 0;
  int _correctAnswer = 0;
  String _operation = '';
  List<int> _options = [];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    _number1 = _random.nextInt(10) + 1; // +1 to avoid zero
    _number2 = _random.nextInt(10) + 1; // +1 to avoid zero
    int operationIndex = _random.nextInt(4);
    switch (operationIndex) {
      case 0:
        _operation = '+';
        _correctAnswer = _number1 + _number2;
        break;
      case 1:
        _operation = '-';
        // if (_number1 < _number2) {
        //   int temp = _number1;
        //   _number1 = _number2;
        //   _number2 = temp;
        // }
        _correctAnswer = _number1 - _number2;
        break;
      case 2:
        _operation = '*';
        _correctAnswer = _number1 * _number2;
        break;
      case 3:
        _operation = '/';
        _correctAnswer = (_number1 / _number2).round();
        _number1 = _correctAnswer * _number2; // Ensure the division is exact
        break;
    }

    _options = [
      _correctAnswer,
      _random.nextInt(20),
      _random.nextInt(20),
    ];

    _options.shuffle();
  }

  void _checkAnswer(int answer) {
    if (answer == _correctAnswer) {
      _showDialog('Correct!', 'Well done! You got it right.');
    } else {
      _showDialog('Wrong! the Correct Answer is $_correctAnswer',
          'Try again in another one');
    }
    setState(() {
      _generateQuestion();
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFa8ae4f)),
              ),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            localizedStrings[widget.lang1]!['options'][0],
            style: GoogleFonts.nunito(
              fontSize: (ScreenUtil().orientation == Orientation.landscape)
                  ? 15.sp
                  : 22.sp,
              color: Color.fromRGBO(7, 7, 7, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.games_outlined,
              color: Color(0xFFa8ae4f),
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFFa8ae4f),
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: [
        Lottie.asset(
          "lib/assest/Animation/test5.json",
          fit: BoxFit.fill,
        ),
        Column(
          children: [
            // Image.asset(
            //   "lib/assest/1 (6).png",
            //   fit: BoxFit.cover,
            //   color: Color(0xFF6b5ba0),
            // ),
            SizedBox(
              height: (ScreenUtil().orientation == Orientation.landscape)
                  ? 20.h
                  : 260.h,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberContainer('$_number1'),
                  SizedBox(width: 10),
                  // Color.fromARGB(255, 111, 183, 39),
                  if (_operation == '+')
                    Image.asset(
                      "lib/assest/square.png",
                      width: (ScreenUtil().orientation == Orientation.landscape)
                          ? 30
                          : 20,
                      height: 30,
                      color: Color(0xFFa8ae4f),
                    )
                  else if (_operation == '-')
                    Image.asset(
                      "lib/assest/minus.png",
                      width: (ScreenUtil().orientation == Orientation.landscape)
                          ? 30
                          : 20,
                      height: 30,
                      color: Color(0xFFa8ae4f),
                    )
                  else if (_operation == '*')
                    Image.asset(
                      "lib/assest/multiplication.png",
                      width: (ScreenUtil().orientation == Orientation.landscape)
                          ? 30
                          : 20,
                      height: 30,
                      color: Color(0xFFa8ae4f),
                    )
                  else
                    Image.asset(
                      "lib/assest/division.png",
                      width: (ScreenUtil().orientation == Orientation.landscape)
                          ? 30
                          : 20,
                      height: 30,
                      color: Color(0xFFa8ae4f),
                    ),
                  // Text(
                  //   _operation,
                  //   style: TextStyle(fontSize: 32),
                  // ),
                  SizedBox(width: 10),
                  _buildNumberContainer('$_number2'),
                  SizedBox(width: 10),
                  Image.asset(
                    "lib/assest/equals-sign.png",
                    width: (ScreenUtil().orientation == Orientation.landscape)
                        ? 30
                        : 25,
                    height: 30,
                    color: Color(0xFFa8ae4f),
                  ),
                  SizedBox(width: 10),
                  _buildNumberContainer('?'),
                ],
              ),
            ),
            SizedBox(height: 20),
            (ScreenUtil().orientation == Orientation.landscape)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _options.map((option) {
                      return InkWell(
                        onTap: () {
                          _checkAnswer(option);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: (ScreenUtil().orientation ==
                                    Orientation.landscape)
                                ? 60.w
                                : 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: Color(
                                  0xFFa8ae4f), // Customize the color as needed
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$option',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Column(
                    children: _options.map((option) {
                      return InkWell(
                        onTap: () {
                          _checkAnswer(option);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: (ScreenUtil().orientation ==
                                    Orientation.landscape)
                                ? 60.w
                                : 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: Color(
                                  0xFFa8ae4f), // Customize the color as needed
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$option',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ]),
    );
  }
}

Widget _buildNumberContainer(String number) {
  return Container(
    width: (ScreenUtil().orientation == Orientation.landscape) ? 40.w : 60.w,
    height: (ScreenUtil().orientation == Orientation.landscape) ? 60.h : 60.h,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 147, 75, 4), // Customize the color as needed
      shape: BoxShape.rectangle,
    ),
    child: Center(
      child: Text(
        '$number',
        style: TextStyle(
            fontSize: (ScreenUtil().orientation == Orientation.landscape)
                ? 15.sp
                : 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w400),
      ),
    ),
  );
}
