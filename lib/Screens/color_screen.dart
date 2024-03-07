import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Shared/card_camera.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:http/http.dart' as http;

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}
// flutter: File: 'D:\vs code\flutter\grd_project\grd_projecttt\lib\assest\IvV2y.png'

// http://127.0.0.1:5000/api/perform_colorD:/vs code/flutter/grd_project/grd_projecttt/lib/assest/IvV2y.png
String Path = '';
List<String> images = [
  "https://www.ephotozine.com/resize/articles/22643/HDR_Off.jpg?RTUdGk5cXyJFCgsJVANtdxU+cVRdHxFYFw1Gewk0T1JYFEtzen5YdgthHHsyBFtG",
  "temp_image1.jpg",
  "lib/assest/2.jpg",
  "lib/assest/3.jpg",
  "lib/assest/4.jpg",
  "lib/assest/money1.jpg",
  "lib/assest/2.jpg",
  "lib/assest/2.jpg",
  "lib/assest/2.jpg",
  "lib/assest/2.jpg",
  "lib/assest/2.jpg"
];
FlutterTts flutterTts = FlutterTts();
String textToSpeak = "";
String data = "null";
Future<void> performColor(File imageFile, String imagePath) async {
  // 10.0.2.2
  var url = Uri.parse('http://10.0.2.2:8000/api/perform_color');
  // File imageFile = await File('$imagePath');

  // Convert the image bytes to base64 string

  var request = http.MultipartRequest('PUT', url);
  // request.files.add(
  //   http.MultipartFile(
  //     'image',
  //     http.ByteStream.fromBytes(
  //         []), // Empty ByteStream since we're not uploading a file
  //     0, // Set length to 0 since it's not a file
  //     filename: imagePath,
  //   ),
  // );
  ByteData imageData = await rootBundle.load(imagePath);
  List<int> bytes = imageData.buffer.asUint8List();

// Create MultipartFile
  var multipartFile = http.MultipartFile.fromBytes(
    'image',
    bytes,
    filename: 'anatomy.jpg', // use the real name if available, or omit
  );

// Add MultipartFile to request
  request.files.add(multipartFile);
  // request.files.add(
  //     await http.MultipartFile.fromPath('image', imagePath //  imageFile.path,
  //         ));

  print("noooooooooooooooooooooooo");
  var response = await request.send();
  if (response.statusCode == 200) {
    print("yesssssssssssssss");
    data = await response.stream.bytesToString();

    // Remove the extra quotes

    print(data);

    // Convert the cleaned string to a list of strings
    // data = cleanedData;

    print('Color Result: $data');
  } else {
    print("herrrrrrrrrrrrrrrrrrrre");
    print(imageFile);
    print('Error:dfdfdfdfdf      ${response.reasonPhrase}');
  }
}

bool isHovering = false;
File? file = null;

bool flg1 = false, flag = false;

class _ColorScreenState extends State<ColorScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Color Recognition",
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
              onPressed: () {
                file = null;

                flg1 = false;
                flag = false;
                // Add your custom logic for handling the back button press
                // You can use Navigator.pop(context) to pop the current screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            lang1: true,
                          )),
                );
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
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  //images.length
                  for (int i = 2; i < images.length; i++)
                    InkWell(
                      onTap: () {
                        file = File(images[i].toString());
                        Path = images[i];
                        print(file?.path);
                        print("!1111111111111");
                        setState(() {});
                      },
                      child: MouseRegion(
                        onEnter: (PointerEnterEvent event) {
                          setState(() {
                            isHovering = true;
                          });
                        },
                        onExit: (PointerExitEvent event) {
                          setState(() {
                            isHovering = false;
                          });
                        },
                        // child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     width: screenSize.width * 0.89,
                        //     // height: screenSize.height * 0.4,
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //           color: Color(0xFF6b5ba0), width: 1.0),
                        //       color: Color.fromARGB(255, 250, 242, 237),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(12)),
                        //     ),
                        //     child: Expanded(
                        //       child: Column(children: [
                        //         SizedBox(
                        //           height: 30,
                        //         ),
                        //         Container(
                        //             height: 100,
                        //             width: 100,
                        //             child: Image.network(
                        //               images[i],
                        //               fit: BoxFit.cover,
                        //             )),
                        //         SizedBox(
                        //           height: 10,
                        //         ),
                        //         Text(
                        //           "",
                        //           style: GoogleFonts.nunito(
                        //             fontSize: 19.0,
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         )
                        //       ]),
                        //     ),
                        //   ),
                        // ),
                        child: CardCamera(
                          Images: images[i],
                          TestName: " ",
                        ),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (file != null)
              ElevatedButton(
                onPressed: () async {
                  // Handle button press
                  print('Button Pressed');
                  flag = true;
                  print(file);
                  await performColor(file!, Path);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 102, 87, 153),
                ),
                child: Text(
                  'Predict',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (flag == true)
              Column(children: [
                Text("Option",
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
                            'Text',
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
                            'Speech',
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
              ]),
            (flg1 == true)
                ? Expanded(
                    child: Text("prediction: " + data,
                        style: GoogleFonts.nunito(
                            fontSize: 15, fontWeight: FontWeight.bold)))
                : Container()
          ])),
    );
  }
}

Future<void> speakText() async {
  await langdetect.initLangDetect();
  String ss = "اهلا";

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
