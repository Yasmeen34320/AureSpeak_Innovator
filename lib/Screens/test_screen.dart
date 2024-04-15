import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:grd_projecttt/Cubits/text_cubit/text_cubit.dart';
import 'package:grd_projecttt/Cubits/text_cubit/text_state.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Shared/initial_state.dart';
import 'package:grd_projecttt/Shared/second_initial.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

import 'package:translator/translator.dart';

String data = "null";
//final translator = GoogleTranslator();

FlutterTts flutterTts = FlutterTts();
String textToSpeak = "";

class Testscreen extends StatefulWidget {
  final bool? lang;
  const Testscreen({super.key, required this.lang});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

File? file = null;
//bool flag = false, flg1 = false;

class _TestscreenState extends State<Testscreen> {
  late final TextCubit _textCubit;

  @override
  void initState() {
    super.initState();
    _textCubit = TextCubit();
    flutterTts = FlutterTts();

    initializeTts();
  }

  @override
  void dispose() {
    _textCubit.close();
    super.dispose();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
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
      create: (context) => _textCubit,
      child: BlocBuilder<TextCubit, TextState>(builder: (context, state) {
        if (state is TextFailureState)
          _speak('unable to predict the photo please try again later ');
        else if (state is TextSuccessState) {
          data = state.data;

          _speak(
              'successfully predict the photo please select an option 5 to the text or  6 for the speech ');
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              (widget.lang == true) ? "Text Extraction " : "استخراج النص  ",
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
                    _textCubit.data = null;
                    _textCubit.getInitial(1);
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
              if (state is TextInitialState)
                InitialState(
                  func: () => _textCubit.getInitial(2),
                  language: widget.lang,
                )
              else
                SecondInitial(
                    file: file!,
                    language1: widget.lang,
                    func: () => _textCubit.getText(file!, "en")),
              // }),

              SizedBox(
                height: 30,
              ),
              // (flag == true)
              //   BlocBuilder<TextCubit, TextState>(builder: ((context, state) {
              if (state is TextLoadingState)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF6b5ba0)), // Change color here
                )
              else if (state is TextSuccessState || _textCubit.data != null)
                Column(children: [
                  Text((widget.lang == true) ? "Option" : 'قم بالإختيار',
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
                          if (state is TextSuccessState) {
                            data = state.data;
                            print("ffffffffffffffff" + data);
                            _textCubit.displayText(state.data);
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
                              (widget.lang == true) ? 'Text' : 'نص',
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
                              (widget.lang == true) ? 'Speech' : 'صوت',
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
              else if (state is TextFailureState)
                // print("in the fail");

                Text("Unable to Predict",
                    style: GoogleFonts.pangolin(
                        fontSize: 22, fontWeight: FontWeight.bold))
              else
                Container(),

              // })),

              //  BlocBuilder<TextCubit, TextState>(builder: (context, state) {
              if (state is TextDisplayState)
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
          floatingActionButton: BlocProvider(
            create: (context) => SpeechRecognitionCubit()..initializeSpeech(),
            child: Speech(
              func: () => _textCubit.getInitial(2),
              func1: () => _textCubit.getText(file!, ('en')),
              func2: () => _textCubit.displayText(data),
            ),
          ),
        );
      }),
    );
  }
}

Future<void> speakText() async {
  await flutterTts.setLanguage('en-US');
  await flutterTts.setSpeechRate(1.0);
  await flutterTts.setPitch(1.0);
  print(data);
  // Set the pitch (adjust as needed)
  await flutterTts.speak(data);
}

class Speech extends StatelessWidget {
  final VoidCallback func, func1, func2;

  Speech(
      {super.key,
      required this.func,
      required this.func1,
      required this.func2});

  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speakErrorMessage() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak('Sorry, I didn\'t understand. Please try again.');
    // Provide feedback to the user and prompt them to record again
  }

  Future<void> _speakSelected(String select) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak('You choose the ' + select);
    // Provide feedback to the user and prompt them to record again
  }

  Future<void> _speakOptions() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(
        'Please select an option: 1 for using a camera, 2 for choosing photo from your device , 3 if you want me to repeat ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechRecognitionCubit, SpeechState>(
      builder: (context, state) {
        print("im in speech");
        return FloatingActionButton(
          onPressed: () async {
            await flutterTts.stop();

            final cubit = context.read<SpeechRecognitionCubit>();
            print("im in if stte + ");
            print(state);
            if (state is SpeechListeningState) {
              print(cubit.recognizedText + "hhhhhhhhhhhhhhhhhhhh");
              String recognizedText =
                  context.read<SpeechRecognitionCubit>().recognizedText;
              context.read<SpeechRecognitionCubit>().recognizedText = ' ';

              List<String> words = recognizedText.split(' ');

              // Iterate through the words to find a number from 1 to 5
              for (String word in words) {
                if (word == 'one' ||
                    word == 'won' ||
                    word == '1' ||
                    word == 'won' ||
                    word == 'wan') {
                  number = 1;
                  break;
                } else if (word == 'two' ||
                    word == '2' ||
                    word == 'to' ||
                    word == 'too') {
                  number = 2;
                  break;
                } else if (word == 'three' ||
                    word == 'tree' ||
                    word == 'thre' ||
                    word == '3') {
                  number = 3;
                  break;
                } else if (word == 'four' || word == 'for' || word == '4') {
                  number = 4;
                  break;
                } else if (word == 'five' ||
                    word == 'hive' ||
                    word == '5' ||
                    word == 'vive') {
                  number = 5;
                  break;
                } else if (word == 'six' ||
                    word == 'sick' ||
                    word == 'sex' ||
                    word == '6' ||
                    word == 'sics') {
                  number = 6;
                }
              }

              if (number == 1) {
                _speakSelected('the Camera');
                try {
                  XFile? xfile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (xfile != null) {
                    print(xfile!.path);
                    file = File(xfile.path);
                    //  _textCubit.getInitial(2);
                    func.call();
                    cubit.stopListening();
                  } else {
                    // User cancelled image selection, close microphone and exit
                    cubit.stopListening();
                    return; // Exit from the else block
                  }
                } catch (e) {
                  // Handle any errors that may occur during image picking
                  print("Error picking image: $e");
                  // Close microphone and exit
                  cubit.stopListening();
                  return;
                }
              } else if (number == 2) {
                number = -1;
                _speakSelected('the photo from device');
                try {
                  XFile? xfile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (xfile != null) {
                    print(xfile.path);
                    file = File(xfile.path);
                    print(file);
                    print("in the ini1");
                    print(func);
                    func.call();
                    cubit.stopListening();
                  } else {
                    // User cancelled image selection, close microphone and exit
                    cubit.stopListening();
                    return; // Exit from the else block
                  }
                } catch (e) {
                  // Handle any errors that may occur during image picking
                  print("Error picking image: $e");
                  // Close microphone and exit
                  cubit.stopListening();
                  return;
                }
              } else if (number == 3) {
                _speakSelected("instructions again");
                _speakOptions();
              } else if (number == 4) {
                func1.call();
              } else if (number == 5) {
                func2.call();
              } else if (number == 6) {
                speakText();
              } else {
                _speakErrorMessage();
              }
              number = -1;
              cubit.stopListening();
            } else {
              cubit.startListening();
            }
          },
          child: Icon(
            state is SpeechListeningState ? Icons.stop : Icons.mic,
          ),
          backgroundColor: state is SpeechListeningState ? Colors.red : null,
        );
      },
    );
  }
}
