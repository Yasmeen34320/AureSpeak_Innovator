import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondInitial extends StatefulWidget {
  final File file;
  final bool? language1;
  final VoidCallback funcCaption, funcText, funcColor;
  final String option;
  const SecondInitial(
      {Key? key,
      required this.file,
      required this.language1,
      required this.funcCaption,
      required this.funcColor,
      required this.funcText,
      required this.option})
      : super(key: key);

  @override
  _SecondInitialState createState() => _SecondInitialState();
}

class _SecondInitialState extends State<SecondInitial> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speech.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenSize.width * 0.89,
              height: (ScreenUtil().orientation == Orientation.landscape)
                  ? screenSize.height * 0.5
                  : screenSize.height * 0.32,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
                color: Color.fromARGB(255, 250, 242, 237),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(children: [
                SizedBox(
                  height: 30.h,
                ),
                // expandedddddddddddddddddddddddd
                Container(
                  height: (ScreenUtil().orientation == Orientation.landscape)
                      ? 100.h
                      : 150.h,
                  width: (ScreenUtil().orientation == Orientation.landscape)
                      ? 100.w
                      : 200.w,
                  child: Image.file(
                    widget.file ?? File('temp_image.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  (widget.language1 == true) ? "Your photo" : "صورتك",
                  style: GoogleFonts.nunito(
                    fontSize:
                        (ScreenUtil().orientation == Orientation.landscape)
                            ? 10.sp
                            : 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          ElevatedButton(
            onPressed: () async {
              // Handle button press
              print('Button Pressed');
              // flag = true;
              String language = '';
              if (widget.language1 == true)
                language = 'en';
              else
                language = 'ar';

              //   await performOCR(file!, language);
              //  await performOCR(file!, language);
              // setState(() {});
              //   _textCubit.getText(file!, language);
              print(widget.file);
              await flutterTts.stop();
              //     'title': {0: 'Color Recognition', 1: 'Text Extraction', 2: "Image Caption"},

              print("in the ini2");
              // print(widget.func);
              if (widget.option == 'Color Recognition')
                widget.funcColor.call();
              else if (widget.option == 'Text Extraction')
                widget.funcText.call();
              else
                widget.funcCaption.call();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Color.fromARGB(255, 102, 87, 153),
            ),
            child: Text(
              (widget.language1 == true) ? 'Predict' : "تنبأ",
              style: GoogleFonts.nunito(
                  fontSize: (ScreenUtil().orientation == Orientation.landscape)
                      ? 11.sp
                      : 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
