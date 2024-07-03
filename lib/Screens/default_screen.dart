import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_langdetect/language.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Cubits/default_cubit/default_cubit.dart';
import 'package:grd_projecttt/Cubits/default_cubit/default_state.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Shared/initial_state.dart';
import 'package:grd_projecttt/Shared/second_initial.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:string_similarity/string_similarity.dart';

String? data = null;
//final translator = GoogleTranslator();

FlutterTts flutterTts = FlutterTts();
String textToSpeak = "";
String? text_language = null;

class DefaultScreen extends StatefulWidget {
  final bool? lang;
  final bool? voice;
  final dynamic title;
  const DefaultScreen(
      {super.key,
      required this.voice,
      required this.lang,
      required this.title});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

//bool flag = false, flg1 = false;
var f = 0;
File? file = null;

class _DefaultScreenState extends State<DefaultScreen> {
  late final DefaultCubit _defaultCubit;
  final stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _defaultCubit = DefaultCubit();
    flutterTts = FlutterTts();
    _speech.initialize();

    initializeTts();
  }

  @override
  void dispose() {
    _defaultCubit.close();
    super.dispose();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);

    await flutterTts.setPitch(1.0);
  }

  Future<void> _speakOptions(option) async {
    print(widget.lang);

    if (widget.lang!) {
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
    // final changeLocaleProvider = Provider.of<ChangeLocaleProvider>(context);

    // if (widget.def == true) {
    //   changeLocaleProvider.setLocale(Locale('en', 'EN'));
    // } else {
    //   changeLocaleProvider.setLocale(Locale('ar', 'AR'));
    //}
    return BlocProvider(
      create: (context) => _defaultCubit,
      child: BlocBuilder<DefaultCubit, DefaultState>(builder: (context, state) {
        if (state is DefaultInitialState)
          f = 0;
        else
          f++;
        if (f == 1)
          _speakOptions({
            'en':
                'you  successfully choose the photo , select 3 if you want me to predict now ',
            'ar':
                'لقد قمت بإختيار الصورة بنجاح من فضلك قم بإختيار 3 إذا كنت تريد مني التنبؤ الأن '
          });
        if (state is DefaultFailureState)
          _speakOptions({
            'en': 'unable to predict the photo please try again later ',
            'ar': "غير قادر علي التنبؤ الان من فضلك قم بالمحاولة لاحقا "
          });
        else if (state is DefaultSuccessState) {
          data = state.data;
          if (widget.title['en'] == 'Text Extraction')
            text_language = state.lang;
          _speakOptions({
            'en':
                'successfully predict the photo please select  6 for the speech  ',
            'ar':
                "لقد تمت العملية بنجاح , من فضلك قم بإختيار 6 للإستماع للنتيجة"
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              (widget.lang!) ? widget.title['en'] : widget.title['ar'],
              // appLocalizations(context).title,
              style: GoogleFonts.nunito(
                fontSize: (ScreenUtil().orientation == Orientation.landscape)
                    ? 13.sp
                    : 22.sp,
                color: Color.fromRGBO(7, 7, 7, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () async {
                      print(voice);
                      if (voice) {
                        await flutterTts.stop();
                        flutterTts.setVolume(0);
                        voice = false;
                        setState(() {});
                      } else {
                        voice = true;
                        flutterTts.setVolume(1);
                        setState(() {});
                      }
                      // Set volume to 0 to mute the voice
                    },
                    child: (voice
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.record_voice_over,
                              color: Color(0xFF6b5ba0),
                              weight: 0.8,
                              size: (ScreenUtil().orientation ==
                                      Orientation.landscape)
                                  ? 18.sp
                                  : 28.sp,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.voice_over_off,
                              color: Color(0xFF6b5ba0),
                              weight: 0.8,
                              size: (ScreenUtil().orientation ==
                                      Orientation.landscape)
                                  ? 18.sp
                                  : 28.sp,
                            ),
                          ))
                    //  Lottie.asset(
                    //   'lib/assest/Animation/stop4.json',
                    //   width: 200,
                    //   height: 200,
                    //   repeat: true,
                    // ),
                    ),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6b5ba0), // Color(0xFF5164BF),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: (ScreenUtil().orientation == Orientation.landscape)
                      ? 13.sp
                      : 25.sp,
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
                    print("herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre" + data!);
                    await flutterTts.stop();
                    //    setState(() {});
                    _defaultCubit.data = null;
                    _defaultCubit.getInitial(1);
                    print('Back button pressed');
                  },
                ),
              ),
            ),
          ),
          body: Container(
            width: screenSize.width,
            height: screenSize.height,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Image.asset(
                  "lib/assest/1 (6).png",
                  fit: BoxFit.cover,
                  color: Color(0xFF6b5ba0),
                ),
                // SizedBox(
                //   height: 18.h,
                // ),

                if (state is DefaultInitialState)
                  InitialState(
                    func: () => _defaultCubit.getInitial(2),
                    language: widget.lang,
                  )
                else
                  SecondInitial(
                      file: file!,
                      language1: widget.lang,
                      option: widget.title['en'],
                      funcText: () => _defaultCubit.getText(file!, ('en')),
                      funcColor: () => _defaultCubit.getColors(file!, ('en')),
                      funcCaption: () =>
                          _defaultCubit.getCaption(file!, ('en'))),
                // }),
                SizedBox(
                  height: 30.h,
                ),
                // (flag == true)
                //   BlocBuilder<TextCubit, TextState>(builder: ((context, state) {
                if (state is DefaultLoadingState)
                  Lottie.asset(
                    // 2 3
                    'lib/assest/Animation/loading/3.json',
                    width: 150.w,
                    height: 150.h,
                    repeat: true,
                  ) // CircularProgressIndicator(
                //   valueColor: AlwaysStoppedAnimation<Color>(
                //       Color(0xFF6b5ba0)), // Change color here
                // )
                else if (state is DefaultSuccessState ||
                    _defaultCubit.data != null)
                  Column(
                    children: [
                      Center(
                        child: Text(
                          ('The prediction is : ${data!}'),
                          style: GoogleFonts.nunito(
                            fontSize: (ScreenUtil().orientation ==
                                    Orientation.landscape)
                                ? 9.sp
                                : 17.sp,
                            color: Color.fromRGBO(7, 7, 7, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: speakText,
                          child: Lottie.asset(
                            // v2
                            'lib/assest/Animation/speech2.json',
                            width: 150.w,
                            height: 150.h,
                            repeat: true,
                          ))
                    ],
                  )
                // Column(children: [
                //   Text((widget.lang!) ? "Option" : 'قم بالإختيار',
                //       style: GoogleFonts.pangolin(
                //           fontSize: 22, fontWeight: FontWeight.bold)),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       ElevatedButton(
                //         onPressed: () async {
                //           // Handle button press
                //           print('Button Pressed');
                //           //   flg1 = true;
                //           //  setState(() {});
                //           await flutterTts.stop();

                //           if (state is DefaultSuccessState) {
                //             data = state.data;
                //             print("ffffffffffffffff" + data);
                //             await flutterTts.stop();

                //             _defaultCubit.displayText(state.data);
                //           }
                //         },
                //         style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(8.0),
                //           ),
                //           backgroundColor: Color.fromARGB(255, 102, 87, 153),
                //         ),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Icon(
                //               Icons.text_format,
                //               color: Colors.white,
                //               size: 30,
                //             ),
                //             SizedBox(width: 4.0),
                //             Text(
                //               (widget.lang!) ? 'Text' : 'نص',
                //               style: GoogleFonts.nunito(
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             ),
                //           ],
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: () async {
                //           print("spek " + data);
                //           await flutterTts.stop();

                //           speakText();
                //         },
                //         style: ElevatedButton.styleFrom(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(8.0),
                //           ),
                //           backgroundColor: Color.fromARGB(255, 102, 87, 153),
                //         ),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Icon(
                //               Icons.record_voice_over_outlined,
                //               color: Colors.white,
                //               size: 30,
                //             ),
                //             SizedBox(width: 6.0),
                //             Text(
                //               (widget.lang!) ? 'Speech' : 'صوت',
                //               style: GoogleFonts.nunito(
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ])

                ///
                else if (state is DefaultFailureState)
                  // print("in the fail");

                  Text("Unable to Predict",
                      style: GoogleFonts.pangolin(
                          fontSize: (ScreenUtil().orientation ==
                                  Orientation.landscape)
                              ? 11.sp
                              : 22.sp,
                          fontWeight: FontWeight.bold))
                else
                  Container(),

                // })),

                //  BlocBuilder<TextCubit, TextState>(builder: (context, state) {
                if (state is DefaultDisplayState)
                  // print("in the disp " + _textCubit.data!);
                  // print("in the disppp" + data);
                  // expandeddddddddddddddd
                  Text("prediction: " + state.data, //data,
                      style: GoogleFonts.nunito(
                          fontSize: (ScreenUtil().orientation ==
                                  Orientation.landscape)
                              ? 13.sp
                              : 17.sp,
                          fontWeight: FontWeight.bold))
                else
                  //  print("kjkjkkjkjkjkj");
                  Container(),
              ]),
            ),
          ),
          floatingActionButton: BlocProvider(
            create: (context) => SpeechRecognitionCubit()..initializeSpeech(),
            child: Speech(
              title: widget.title['en'],
              func: () => _defaultCubit.getInitial(2),
              func1: () => _defaultCubit.getCaption(file!, ('en')),
              func3: () => _defaultCubit.getColors(file!, ('en')),
              func4: () => _defaultCubit.getText(file!, ('en')),
              func2: () => _defaultCubit.displayText(data!),
              language: (widget.lang!) ? true : false,
              statee: _defaultCubit.state,
            ),
          ),
        );
      }),
    );
  }
}

Future<void> speakText() async {
  if (text_language == 'ar')
    await flutterTts.setLanguage('ar-AR');
  else
    await flutterTts.setLanguage('en-US');

  await flutterTts.setSpeechRate(0.25);
  await flutterTts.setPitch(1.0); // Set the pitch (adjust as needed)
  await flutterTts.speak(data!);
}

class Speech extends StatelessWidget {
  final VoidCallback func, func1, func2, func3, func4;
  final String? title;
  Speech(
      {super.key,
      required this.title,
      required this.func3,
      required this.func4,
      required this.func,
      required this.func1,
      required this.func2,
      this.language,
      required this.statee});

  final FlutterTts flutterTts = FlutterTts();
  final bool? language;
  final DefaultState statee;
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

  var number = -1;
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
            print(statee);
            if (state is SpeechListeningState) {
              print(cubit.recognizedText + "hhhhhhhhhhhhhhhhhhhh");
              String recognizedText =
                  context.read<SpeechRecognitionCubit>().recognizedText;
              context.read<SpeechRecognitionCubit>().recognizedText = ' ';

              List<String> words = recognizedText.split(' ');

              // Iterate through the words to find a number from 1 to 5
              for (String word in words) {
                if (statee is DefaultInitialState) {
                  if (word == 'one' ||
                      word == 'won' ||
                      word == '1' ||
                      word == 'won' ||
                      word == 'wan' ||
                      word == "واحد" ||
                      word == "احد" ||
                      word == "واهد" ||
                      word == "وان" ||
                      StringSimilarity.compareTwoStrings(word, "واحد") >= 0.5) {
                    number = 1;
                    break;
                  } else if (word == "اثنان" ||
                      word == "اثنين" ||
                      word == "تو" ||
                      word == "توو" ||
                      word == "اتنان" ||
                      word == "اتنين" ||
                      word == 'two' ||
                      word == '2' ||
                      word == 'to' ||
                      word == 'too' ||
                      StringSimilarity.compareTwoStrings(word, "اثنان") >=
                          0.5) {
                    number = 2;
                    break;
                  } else if (StringSimilarity.compareTwoStrings(
                              word, "اربعة") >=
                          0.5 ||
                      word == "اربعة" ||
                      word == "فور" ||
                      word == "اربع" ||
                      word == 'four' ||
                      word == 'for' ||
                      word == '4') {
                    number = 4;
                    break;
                  }
                } else {
                  if (word == 'three' ||
                      word == "تلاتة" ||
                      word == "ثلاثة" ||
                      word == "تلات" ||
                      word == 'tree' ||
                      word == 'thre' ||
                      word == '3' ||
                      word == 'sree' ||
                      StringSimilarity.compareTwoStrings(word, "ثلاثة") >=
                          0.5) {
                    number = 3;
                    break;
                  } else if (word == "اربعة" ||
                      word == "فور" ||
                      word == "اربع" ||
                      word == 'four' ||
                      word == 'for' ||
                      word == '4' ||
                      StringSimilarity.compareTwoStrings(word, "اربعة") >=
                          0.5) {
                    number = 4;
                    break;
                  } else if (word == 'five' ||
                      word == 'hive' ||
                      word == '5' ||
                      word == 'vive' ||
                      word == "فايف" ||
                      word == "خمسة" ||
                      word == "خمس" ||
                      StringSimilarity.compareTwoStrings(word, "خمسة") >= 0.5) {
                    number = 5;
                    break;
                  } else if (word == "ستة" ||
                      word == "سكس" ||
                      word == "سيكس" ||
                      word == 'six' ||
                      word == 'sick' ||
                      word == 'sex' ||
                      word == '6' ||
                      word == 'sics' ||
                      StringSimilarity.compareTwoStrings(word, "ستة") >= 0.5) {
                    number = 6;
                  }
                }
              }

              if (number == 1) {
                _speakOptions({
                  'ar': 'لقد قمت بإختيار الكاميرا , من فضلك قم بإلتقاط الصورة',
                  'en': 'you choose the camera , please take the photo'
                });
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
                _speakOptions({
                  'ar': 'لقد قمت بإختيار الهاتف , من فضلك قم بإختيار الصورة',
                  'en':
                      'you choose taking the photo from device , please select the photo'
                });
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
                //     'title': {0: 'Color Recognition', 1: 'Text Extraction', 2: "Image Caption"},
/*  func1: () => _defaultCubit.getCaption(file!, ('en')),
              func3:()=>_defaultCubit.getColors(file!, ('en')),
              func4:()=>_defaultCubit.getText(file!, ('en')), */
                if (title == "Color Recognition") {
                  _speakOptions({
                    'ar':
                        'سنقوم بالتعرف علي اللون في الصورة , من فضلك قم بالإنتظار بضعة ثوانى',
                    'en':
                        'we will predict the color of the photo , please wait for few seconds'
                  });
                  func3.call();
                } else if (title == "Text Extraction") {
                  _speakOptions({
                    'ar':
                        'سنقوم بإستخراج النص من  الصورة , من فضلك قم بالإنتظار بضعة ثوانى',
                    'en':
                        'we will extract the text from the photo , please wait for few seconds'
                  });
                  func4.call();
                } else {
                  _speakOptions({
                    'ar': 'سنقوم بوصف الصورة , من فضلك قم بالإنتظار بضعة ثوانى',
                    'en':
                        'we will describe the photo , please wait for few seconds'
                  });
                  func1.call();
                }

                cubit.stopListening();
              } else if (number == 4) {
                _speakOptions({
                  'en':
                      "please select an option , 1 for using the camera , 2 for choosing the photo from device , 4 if you want me to repeat",
                  'ar':
                      "من فضلك قم بالإختيار , 1 إذا كنت تريد استخدام الكاميرا , 2 إذا كنت ترغب بإختيار صورة من الجهاز , 4 إذا كنت ترغب فى إعادة هذه التعليمات مرة أخرى "
                });
              } else if (number == 5) {
                func2.call();
                cubit.stopListening();
              } else if (number == 6) {
                speakText();
                cubit.stopListening();
              } else {
                _speakOptions({
                  'en': 'Sorry , I didn' 't understand please try again  ',
                  'ar': 'نأسف لم نفهم اختيارك يرجى المحاولة مرة أخرى لاحقا '
                });
              }
              number = -1;
              cubit.stopListening();
            } else {
              number = -1;
              cubit.startListening(language!);
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
