import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/default_screen.dart';

import 'package:image_picker/image_picker.dart';

class InitialState extends StatelessWidget {
  final VoidCallback func;
  final bool? language;
  const InitialState({super.key, required this.func, required this.language});
  Future<void> _speakOptions(option) async {
    if (language!) {
      await flutterTts.setLanguage('en-US');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(option['en']);
    } else {
      await flutterTts.setLanguage('ar-AR');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(0.8);
      await flutterTts.speak(option['ar']);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        height: ((ScreenUtil().orientation == Orientation.landscape))
            ? ScreenUtil().screenHeight * 0.4
            : ScreenUtil().screenHeight * 0.25,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // expandedddddddddddddddddd
            child: InkWell(
              onTap: () async {
                _speakOptions({
                  'ar': 'لقد قمت بإختيار الكاميرا , من فضلك قم بإلتقاط الصورة',
                  'en': 'you choose the camera , please take the photo'
                });
                XFile? xfile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                print(xfile!.path);
                file = File(xfile.path);
                //  _textCubit.getInitial(2);
                func.call();
                // setState(() {});
              },
              child: Container(
                width: screenSize.width * 0.45,
                height: ((ScreenUtil().orientation == Orientation.landscape))
                    ? screenSize.height * 0.4
                    : screenSize.height * 0.3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 242, 237),
                  boxShadow: [],
                  border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(children: [
                  SizedBox(
                    height:
                        ((ScreenUtil().orientation == Orientation.landscape))
                            ? 10
                            : 18.h,
                  ),
                  // expandeddddddddddddddddddddddd
                  Image.asset(
                    "lib/assest/Camera.png",
                    fit: BoxFit.cover,
                    width: ((ScreenUtil().orientation == Orientation.landscape))
                        ? 60.w
                        : 130.w,
                    height: (ScreenUtil().orientation == Orientation.landscape)
                        ? 60.h
                        : 100.h,
                  ),
                  SizedBox(
                    height:
                        ((ScreenUtil().orientation == Orientation.landscape))
                            ? 20.h
                            : 0,
                  ),
                  Flexible(
                      child: Text(
                    //"Using Camera",
                    (language == true) ? "Using Camera" : "بإستخدام الكاميرا",
                    // appLocalizations(context).option,
                    style: GoogleFonts.nunito(
                      fontSize:
                          ((ScreenUtil().orientation == Orientation.landscape))
                              ? 10.sp
                              : 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // expandedddddddddddddddddd
            child: InkWell(
              onTap: () async {
                _speakOptions({
                  'ar': 'لقد قمت بإختيار الهاتف , من فضلك قم بإختيار الصورة',
                  'en':
                      'you choose taking the photo from device , please select the photo'
                });
                XFile? xfile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                print(xfile!.path);

                file = File(xfile!.path);
                print(file);
                //   _textCubit.getInitial(2);
                print("in the ini1");
                print(func);
                func.call();
                //      setState(() {});
              },
              child: Container(
                width: screenSize.width * 0.45,
                height: ((ScreenUtil().orientation == Orientation.landscape))
                    ? screenSize.height * 0.4
                    : screenSize.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
                  color: Color.fromARGB(255, 250, 242, 237),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(children: [
                  SizedBox(
                    height:
                        ((ScreenUtil().orientation == Orientation.landscape))
                            ? 10
                            : 30.h,
                  ),
                  // expandedddddddddddddddddd
                  Container(
                    height:
                        ((ScreenUtil().orientation == Orientation.landscape))
                            ? 62.h
                            : 70.h,
                    width: ((ScreenUtil().orientation == Orientation.landscape))
                        ? 40.w
                        : 100.w,
                    child: Image.asset(
                      "lib/assest/folder.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                      child: Text(
                    //  "From Device"
                    (language == true) ? "From Device" : "من الجهاز",
                    // appLocalizations(context).option1,
                    style: GoogleFonts.nunito(
                      fontSize:
                          ((ScreenUtil().orientation == Orientation.landscape))
                              ? 10.sp
                              : 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
                ]),
              ),
            ),
          ),
        ]));
  }
}
