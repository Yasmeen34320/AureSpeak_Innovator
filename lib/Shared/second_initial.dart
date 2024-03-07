import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondInitial extends StatelessWidget {
  final File file;
  final bool? language1;
  final VoidCallback func;
  const SecondInitial(
      {super.key,
      required this.file,
      required this.language1,
      required this.func});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenSize.width * 0.89,
            height: screenSize.height * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
              color: Color.fromARGB(255, 250, 242, 237),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                    child: Image.file(
                  file ?? File('temp_image.png'),
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (language1 == true) ? "Your photo" : "صورتك",
                style: GoogleFonts.nunito(
                  fontSize: 19.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () async {
            // Handle button press
            print('Button Pressed');
            // flag = true;
            String language = '';
            if (language1 == true)
              language = 'en';
            else
              language = 'ar';

            //   await performOCR(file!, language);
            //  await performOCR(file!, language);
            // setState(() {});
            //   _textCubit.getText(file!, language);
            print(file);
            print("in the ini2");
            print(func);
            func?.call();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Color.fromARGB(255, 102, 87, 153),
          ),
          child: Text(
            (language1 == true) ? 'Predict' : "تنبأ",
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
