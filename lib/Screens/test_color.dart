import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Cubits/color_cubit/color_cubit.dart';
import 'package:grd_projecttt/Cubits/color_cubit/color_state.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Screens/test_screen.dart';
import 'package:grd_projecttt/Shared/initial_state.dart';
import 'package:grd_projecttt/Shared/second_initial.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

String data = "null";
//final translator = GoogleTranslator();

FlutterTts flutterTts = FlutterTts();
String textToSpeak = "";

class TestColor extends StatefulWidget {
  final bool? lang;
  const TestColor({super.key, required this.lang});

  @override
  State<TestColor> createState() => _TestColorState();
}

//bool flag = false, flg1 = false;

class _TestColorState extends State<TestColor> {
  late final ColorsCubit _colorCubit;

  @override
  void initState() {
    super.initState();
    _colorCubit = ColorsCubit();
    flutterTts = FlutterTts();
    initializeTts();
  }

  @override
  void dispose() {
    _colorCubit.close();
    super.dispose();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // final changeLocaleProvider = Provider.of<ChangeLocaleProvider>(context);

    // if (widget.def == true) {
    //   changeLocaleProvider.setLocale(Locale('en', 'EN'));
    // } else {
    //   changeLocaleProvider.setLocale(Locale('ar', 'AR'));
    // }

    return BlocProvider(
      create: (context) => _colorCubit,
      child: BlocBuilder<ColorsCubit, ColorsState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              (widget.lang!) ? "Color Recognition" : "التعرف علي اللون",
              // appLocalizations(context).title,
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
                                  lang1: widget.lang,
                                )),
                      );
                    file = null;
                    // flag = false;
                    // flg1 = false;
                    print("herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre" + data);
                    await flutterTts.stop();
                    //    setState(() {});
                    _colorCubit.data = null;
                    _colorCubit.getInitial(1);
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

              SizedBox(
                height: 20,
              ),
              if (state is ColorsInitialState)
                InitialState(
                  func: () => _colorCubit.getInitial(2),
                  language: widget.lang,
                )
              else
                SecondInitial(
                    file: file!,
                    language1: widget.lang,
                    func: () => _colorCubit.getColors(file!, ('en'))),
              // }),

              SizedBox(
                height: 30,
              ),
              // (flag == true)
              //   BlocBuilder<TextCubit, TextState>(builder: ((context, state) {
              if (state is ColorsLoadingState)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF6b5ba0)), // Change color here
                )
              else if (state is ColorsSuccessState || _colorCubit.data != null)
                Column(children: [
                  Text((widget.lang!) ? "Option" : 'قم بالإختيار',
                      style: GoogleFonts.pangolin(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                          print('Button Pressed');
                          //   flg1 = true;
                          //  setState(() {});
                          if (state is ColorsSuccessState) {
                            data = state.data;
                            print("ffffffffffffffff" + data);
                            _colorCubit.displayColors(state.data);
                          }
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
                              (widget.lang!) ? 'Text' : 'نص',
                              style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("spek " + data);
                          speakText();
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
                              Icons.record_voice_over_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              (widget.lang!) ? 'Speech' : 'صوت',
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
              else if (state is ColorsFailureState)
                // print("in the fail");

                Text("Unable to Predict",
                    style: GoogleFonts.pangolin(
                        fontSize: 22, fontWeight: FontWeight.bold))
              else
                Container(),

              // })),

              //  BlocBuilder<TextCubit, TextState>(builder: (context, state) {
              if (state is ColorsDisplayState)
                // print("in the disp " + _textCubit.data!);
                // print("in the disppp" + data);
                Expanded(
                    child: Text("prediction: " + state.data, //data,
                        style: GoogleFonts.nunito(
                            fontSize: 15, fontWeight: FontWeight.bold)))
              else
                //  print("kjkjkkjkjkjkj");
                Container(),
            ]),
          ),
        );
      }),
    );
  }
}

Future<void> speakText() async {
  await langdetect.initLangDetect();
  print(data);
  await flutterTts
      .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
  await flutterTts.setPitch(1.0); // Set the pitch (adjust as needed)
  await flutterTts.speak(data);
}
