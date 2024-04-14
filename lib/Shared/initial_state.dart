import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/test_screen.dart';

import 'package:image_picker/image_picker.dart';

class InitialState extends StatelessWidget {
  final VoidCallback func;
  final bool? language;
  const InitialState({super.key, required this.func, required this.language});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Flexible(
        child: Container(
            width: screenSize.width,
            height: screenSize.height * .25,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // expandedddddddddddddddddd
                child: InkWell(
                  onTap: () async {
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    print(xfile!.path);
                    file = File(xfile.path);
                    //  _textCubit.getInitial(2);
                    func.call();
                    // setState(() {});
                  },
                  child: Container(
                    width: screenSize.width * 0.45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 242, 237),
                      boxShadow: [],
                      border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      // expandeddddddddddddddddddddddd
                      Image.asset(
                        "lib/assest/Camera.png",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                          child: Text(
                        //"Using Camera",
                        (language == true)
                            ? "Using Camera"
                            : "بإستخدام الكاميرا",
                        // appLocalizations(context).option,
                        style: GoogleFonts.nunito(
                          fontSize: 19.0,
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
                    XFile? xfile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
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
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
                      color: Color.fromARGB(255, 250, 242, 237),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      // expandedddddddddddddddddd
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          "lib/assest/folder.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                          child: Text(
                        //  "From Device"
                        (language == true) ? "From Device" : "من الجهاز",
                        // appLocalizations(context).option1,
                        style: GoogleFonts.nunito(
                          fontSize: 19.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                    ]),
                  ),
                ),
              ),
            ])));
  }
}
