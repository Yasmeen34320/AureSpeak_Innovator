import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Shared/card_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:translator/translator.dart';

String data = "null";
final translator = GoogleTranslator();
// ignore: prefer_typing_uninitialized_variables

String data1 = "null";
var dd = "nn";
FlutterTts flutterTts = FlutterTts();
String textToSpeak = "";

Future<void> performOCR(File imageFile, String language) async {
  var request = http.MultipartRequest(
    'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2
    Uri.parse('http://127.0.0.1:8000/api/perform_ocr/$language'),
  );
  request.files.add(http.MultipartFile(
    'image',
    imageFile.readAsBytes().asStream(),
    imageFile.lengthSync(),
    filename: 'image.png',
  ));

  var response = await request.send();
  if (response.statusCode == 200) {
    data = await response.stream.bytesToString();
    dd = data;
    // Remove the extra quotes
    String cleanedData = data.replaceAll('"', '');

    data = cleanedData.replaceAll('\\n', ' ');
    print(data);
    print(cleanedData);
    // Convert the cleaned string to a list of strings
    // data = cleanedData;
    final translatedText = (await translator.translate(data, to: 'ar'));
    print(translatedText);
    data1 = translatedText.text;
    print(data1);
    print('OCR Result: $data');
  } else {
    print('Error: ${response.reasonPhrase}');
  }
}

class Testscreen extends StatefulWidget {
  final bool? def;
  const Testscreen({super.key, required this.def});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

File? file = null;
bool flag = false, flg1 = false;

class _TestscreenState extends State<Testscreen> {
  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initializeTts();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final changeLocaleProvider = Provider.of<ChangeLocaleProvider>(context);

    if (widget.def == true) {
      changeLocaleProvider.setLocale(Locale('en', 'EN'));
    } else {
      changeLocaleProvider.setLocale(Locale('ar', 'AR'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations(context).title,
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Color.fromRGBO(7, 7, 7, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF6b5ba0), // Color(0xFF5164BF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 25,
              color: Colors.white,
              onPressed: () async {
                // Add your custom logic for handling the back button press
                // You can use Navigator.pop(context) to pop the current screen
                if (file == null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              def1: widget.def,
                            )),
                  );
                file = null;
                flag = false;
                flg1 = false;
                await flutterTts.stop();
                setState(() {});
                print('Back button pressed');
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(children: [
          Image.asset(
            "lib/assest/1 (6).png",
            fit: BoxFit.cover,
            color: Color(0xFF6b5ba0),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
              ((file == null))
                  ? (widget.def!)
                      ? "Upload Photo"
                      : "قم بتحميل صورة"
                  : "",
              style: GoogleFonts.pangolin(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ), //////////////////////////////////////////////////
          (file == null)
              ? Flexible(
                  child: Container(
                      width: screenSize.width,
                      height: screenSize.height * .25,
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: InkWell(
                              onTap: () async {
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);

                                file = File(xfile!.path);
                                setState(() {});
                              },
                              child: Container(
                                width: screenSize.width * 0.45,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 242, 237),
                                  boxShadow: [],
                                  border: Border.all(
                                      color: Color(0xFF6b5ba0), width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Expanded(
                                      child: Image.asset(
                                    "lib/assest/Camera.png",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                      child: Text(
                                    //"Using Camera",
                                    appLocalizations(context).option,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: InkWell(
                              onTap: () async {
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                file = File(xfile!.path);
                                print(file);
                                setState(() {});
                              },
                              child: Container(
                                width: screenSize.width * 0.45,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF6b5ba0), width: 1.0),
                                  color: Color.fromARGB(255, 250, 242, 237),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Expanded(
                                      child: Image.asset(
                                    "lib/assest/folder.png",
                                    fit: BoxFit.cover,
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                      child: Text(
                                    //  "From Device"
                                    appLocalizations(context).option1,
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
                        ),
                      ])))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenSize.width * 0.89,
                        height: screenSize.height * 0.3,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF6b5ba0), width: 1.0),
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
                              file!,
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (widget.def!) ? "Your photo" : "صورتك",
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
                        flag = true;
                        String language = '';
                        if (widget.def!)
                          language = 'en';
                        else
                          language = 'ar';

                        //   await performOCR(file!, language);
                        await performOCR(file!, language);
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 102, 87, 153),
                      ),
                      child: Text(
                        (widget.def!) ? 'Predict' : "تنبأ",
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),

          SizedBox(
            height: 30,
          ),
          (flag == true)
              ? Column(children: [
                  Text((widget.def!) ? "Option" : 'قم بالإختيار',
                      style: GoogleFonts.pangolin(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                          print('Button Pressed');
                          flg1 = true;
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Color.fromARGB(255, 102, 87, 153),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.text_format,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              (widget.def!) ? 'Text' : 'نص',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: speakText,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Color.fromARGB(255, 102, 87, 153),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.record_voice_over_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              (widget.def!) ? 'Speech' : 'صوت',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])
              : Container(),
          (flg1 == true)
              ? Expanded(
                  child: Text("prediction: " + data,
                      style: GoogleFonts.nunito(
                          fontSize: 15, fontWeight: FontWeight.bold)))
              : Container()
        ]),
      ),
    );
  }
}

Future<void> speakText() async {
  await langdetect.initLangDetect();
  String ss = "اهلا";
  final translatedText = (await translator.translate(data, to: 'ar'));
  data1 = translatedText.text;
  final language = await langdetect.detect(data);
  print(language);
  print(data);
  await flutterTts.setLanguage((language == 'ar')
      ? language
      : ('en')); // Set the language (change as needed)
  await flutterTts
      .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
  await flutterTts.setPitch(1.0); // Set the pitch (adjust as needed)
  await flutterTts.speak(data);
}
