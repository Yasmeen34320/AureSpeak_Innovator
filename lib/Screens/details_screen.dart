import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_langdetect/language.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Cubits/language_cubit/language_cubit.dart';
import 'package:grd_projecttt/Cubits/language_cubit/language_state.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:grd_projecttt/Screens/default_screen.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:grd_projecttt/Cubits/text_cubit/text_cubit.dart';
import 'package:grd_projecttt/Cubits/text_cubit/text_state.dart';
import 'package:grd_projecttt/Shared/card_camera.dart';
import 'package:grd_projecttt/Shared/card_category.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DetailsScreen extends StatefulWidget {
  bool? lang1;
  DetailsScreen({super.key, required this.lang1});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

var number = -1;
Map<String, Map<String, dynamic>> localizedStrings = {
  'en': {
    'title': {0: 'Color Recognition', 1: 'Text Extraction', 2: "Image Caption"},
    'title1': 'Text Extraction',
    'option': 'Using Camera',
    'option1': 'From Device',
  },
  'ar': {
    'title': {0: 'التعرف علي اللون', 1: ' استخراج الصور', 2: 'وصف الصورة '},
    'title1': ' استخراج النص',
    'option': 'بإستخدام الكاميرا ',
    'option1': 'من الجهاز',
  },
};
// AppLocalizations appLocalizations(BuildContext context) {
//   final locale =
//       Provider.of<ChangeLocaleProvider>(context, listen: false).locale;
//   final localeCode = locale.languageCode;
//   return AppLocalizations(localeCode);
// }

// class AppLocalizations {
//   final String _localeCode;

//   AppLocalizations(this._localeCode);

//   String get title => _getTranslation('title');
//   String get title1 => _getTranslation('title1');
//   String get option => _getTranslation('option');
//   String get option1 => _getTranslation('option1');
//   String _getTranslation(String key) {
//     final locale = Intl.canonicalizedLocale(_localeCode);
//     return localizedStrings[locale]?.containsKey(key) == true
//         ? localizedStrings[locale]![key]!
//         : 'Localization key not found: $key';
//   }
// }

// class ChangeLocaleProvider extends ChangeNotifier {
//   Locale _locale = Locale('en', 'US');

//   Locale get locale => _locale;

//   void setLocale(Locale newLocale) {
//     _locale = newLocale;
//     notifyListeners();
//   }
// }

class _DetailsScreenState extends State<DetailsScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  var f = 1;

  @override
  void initState() {
    super.initState();
    _speech.initialize();
    f = 0;
    _speakOptions({
      'ar':
          "  ,انت الان تستخدم اللغة العربية , إذا كنت تريد تغيير اللغة من فضلك قم بالضغط على الزر في أعلى الشاشة على اليمين , من فضلك قم بالإختيار , 1 اذا كنت تريد التعرف على اللون , 2 اذا كنت تريد استخراج النص من الصورة , 3 اذا كنت تريد وصف الصورة , 4 اذا كنت تريد اعادة هذه التعليمات مرة أخرى",
      'en':
          "you are using the english language now , if you want to change the language please press the button that is located on the right top of the screen , Please select an option: 1 for color recognition, 2 for text extraction , 3 for Image Caption, 4 if you want me to repeat"
    }, (widget.lang1 == true) ? 1 : 0);
  }

  Future<void> _speakOptions(option, lan) async {
    print(widget.lang1);
    print(lan);
    print("in laaaaaaaaaaaaaaaannnnnn");
    if (lan == 1) {
      await flutterTts.setLanguage('en-US');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(option['en']);
    } else {
      await flutterTts.setLanguage('ar-AR');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(option['ar']);
    }

    // await flutterTts.awaitSpeakCompletion(true);
    // if (f == 0) {
    //   f = 1;

    //   // Adjust the duration as needed
    //   await _speakOptions({
    //     'ar':
    //         'من فضلك قم بالإختيار , 1 اذا كنت تريد التعرف على اللون , 2 اذا كنت تريد استخراج النص من الصورة , 3 اذا كنت تريد وصف الصورة , 4 اذا كنت تريد اعادة هذه التعليمات مرة أخرى',
    //     'en':
    //         'Please select an option: 1 for color recognition, 2 for text extraction , 3 for Image Caption, 4 if you want me to repeat'
    //   }, lan);
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isHovering = false;
    // final changeLocaleProvider = Provider.of<ChangeLocaleProvider>(context);
    // if (widget.def1!) {
    //   changeLocaleProvider.setLocale(Locale('en', 'EN'));
    // } else {
    //   changeLocaleProvider.setLocale(Locale('ar', 'AR'));
    // }
    var screenSize = MediaQuery.of(context).size; // Color(0xFFF7F5F5)
    var color = Colors
        .white; //Color.fromARGB(255, 160, 64,64); //Color(0xFF5164BF); //Color.fromARGB(255, 31, 122, 207);
    // List<String> datacolor = [
    //   appLocalizations(context).title,
    //   appLocalizations(context).title1
    // ];
    List<String> databreif = [
      "involves the capability to identify and process colors within images or through the device's camera.",
      "simply point your device's camera at banknotes, and it  will identify the currency denomination."
    ];
    List<dynamic> dataimage = [
      Lottie.asset(
        "lib/assest/Animation/color3.json",
        width: 150,
        height: 150,
        repeat: true,
      ),
      Image.asset(
        'lib/assest/Animation/text2.gif',
        width: 200, // Optional: Set the width
        height: 200, // Optional: Set the height
      ),
      // SvgPicture.asset(
      //   'lib/assest/Animation/search1.svg',
      //   width: 200, // Optional: Set the width
      //   height: 200, // Optional: Set the height
      // ),
      Image.asset(
        'lib/assest/Animation/image2.gif',
        width: 200, // Optional: Set the width
        height: 200, // Optional: Set the height
      ),
      // "lib/assest/Animation/text1.json",
      // "lib/assest/Animation/image.json",
      // "lib/assest/color1.jpg",
      // "lib/assest/7.jpg",
      // "lib/assest/color1.jpg"
    ];

    return BlocConsumer<LanguageCubit, LanguageState>(
      builder: (context, state) {
        // List<dynamic> p = [
        //   TestColor(
        //     lang: (BlocProvider.of<LanguageCubit>(context).language1 == 'en')
        //         ? true
        //         : false,
        //   ),
        //   Testscreen(
        //       lang: (BlocProvider.of<LanguageCubit>(context).language1 == 'en')
        //           ? true
        //           : false),
        //   TestImage(
        //       lang: (BlocProvider.of<LanguageCubit>(context).language1 == 'en')
        //           ? true
        //           : false)
        // ];
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Auraspeak Innovator',
              style: GoogleFonts.nunito(
                fontSize: 25,
                color: Color.fromRGBO(7, 7, 7, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: color,
            actions: [
              IconButton(
                  onPressed: () async {
                    // if (widget.def1!) {
                    //   widget.def1 = false;
                    //   changeLocaleProvider.setLocale(Locale('ar', 'AR'));
                    //   //   setState(() {});
                    // } else {
                    //   widget.def1 = true;
                    //   changeLocaleProvider.setLocale(Locale('en', 'EN'));
                    //   // setState(() {});
                    // }
                    await flutterTts.stop();
                    var ff = 1;
                    print("the languageeeeeeeeee");
                    print(BlocProvider.of<LanguageCubit>(context).language1);

                    if (BlocProvider.of<LanguageCubit>(context).language1 ==
                        'en') {
                      widget.lang1 = false;
                      ff = 0;
                      BlocProvider.of<LanguageCubit>(context).getLanguage('ar');
                    } else {
                      ff = 1;
                      widget.lang1 = true;
                      BlocProvider.of<LanguageCubit>(context).getLanguage('en');
                    }
                    f = 0;
                    print(BlocProvider.of<LanguageCubit>(context).language1);
                    print("in the call");
                    _speakOptions({
                      'ar':
                          "  ,انت الان تستخدم اللغة العربية , إذا كنت تريد تغيير اللغة من فضلك قم بالضغط على الزر في أعلى الشاشة على اليمين , من فضلك قم بالإختيار , 1 اذا كنت تريد التعرف على اللون , 2 اذا كنت تريد استخراج النص من الصورة , 3 اذا كنت تريد وصف الصورة , 4 اذا كنت تريد اعادة هذه التعليمات مرة أخرى",
                      'en':
                          "you are using the english language now , if you want to change the language please press the button that is located on the right top of the screen , Please select an option: 1 for color recognition, 2 for text extraction , 3 for Image Caption, 4 if you want me to repeat"
                    }, (ff == 1) ? 1 : 0);
                  },
                  icon: Icon(Icons.language))
            ],
            leading: InkWell(
                onTap: () async {
                  await flutterTts.stop();
                },
                child: Icon(Icons.voice_over_off)
                //  Lottie.asset(
                //   'lib/assest/Animation/stop4.json',
                //   width: 200,
                //   height: 200,
                //   repeat: true,
                // ),
                ),

            //  Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFF6b5ba0), // Color(0xFF5164BF),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     child:
            //      IconButton(
            //       icon: Icon(Icons.arrow_back),
            //       iconSize: 25,
            //       color: Colors.white,
            //       onPressed: () {
            //         // Add your custom logic for handling the back button press
            //         // You can use Navigator.pop(context) to pop the current screen
            //         print('Back button pressed');
            //       },
            //     ),
            //   ),
            // ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "lib/assest/1 (6).png",
                  fit: BoxFit.cover,
                  color: Color(0xFF6b5ba0),
                ),
                SizedBox(
                  height: 18,
                ),
                // expandeddddddddddddddddddddddddddddd
                SingleChildScrollView(
                  child: Column(children: [
                    for (var i = 0; i < dataimage.length!; i++)
                      InkWell(
                        onTap: () async {
                          await flutterTts.stop();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                // Testscreen(def: widget.def1)
                                builder: (context) => DefaultScreen(
                                      lang: (BlocProvider.of<LanguageCubit>(
                                                      context)
                                                  .language1 ==
                                              'en')
                                          ? true
                                          : false,
                                      title: {
                                        'en': localizedStrings['en']!['title']
                                            [i],
                                        'ar': localizedStrings['ar']!['title']
                                            [i]
                                      },
                                    )),
                          );
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // expandeddddddddddddddddddddddddddddd
                            child: Container(
                              width: screenSize.width * 0.89,
                              // height: screenSize.height * 0.4,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: dataimage[i],
                                ),
                                Text(
                                  ' ${localizedStrings[BlocProvider.of<LanguageCubit>(context).language1]!['title'][i]}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 19.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          // child: CardCamera(
                          //   Images: dataimage[i],

                          //   TestName: localizedStrings[
                          //       BlocProvider.of<LanguageCubit>(context)
                          //           .language1]!['title'][i], //datacolor[i],
                          //   brief: databreif[i],
                          //   path: p[i],
                          // ),
                        ),
                      )
                  ]),
                )
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 2, // Replace with your actual item count
                //     itemBuilder: (context, index) {
                //       // Replace with your list item widget
                //       return InkWell(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder: (context) => DetailsScreen()),
                //           );
                //         },
                //         child: CardCategory(
                //           Images: dataimage[index],
                //           TestName: datacolor[index],
                //           brief: databreif[index],
                //           path: p[index],
                //         ),
                //       );
                //     },
                //   ),
                // ),
                ,
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        child: Image.asset(
                          "lib/assest/1 (1).png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        child: Image.asset(
                          "lib/assest/1 (4).png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: BlocProvider(
            create: (context) => SpeechRecognitionCubit()..initializeSpeech(),
            child: Speech(
              language:
                  (BlocProvider.of<LanguageCubit>(context).language1 == 'en')
                      ? true
                      : false,
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class Speech extends StatelessWidget {
  Speech({super.key, required this.language});
  final bool language;
  final FlutterTts flutterTts = FlutterTts();

  // Future<void> _speakErrorMessage() async {
  //   await flutterTts
  //       .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
  //   await flutterTts.setPitch(1.0);
  //   await flutterTts.speak('Sorry, I didn\'t understand. Please try again.');
  //   // Provide feedback to the user and prompt them to record again
  // }

  // Future<void> _speakSelected(String select) async {
  //   await flutterTts
  //       .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
  //   await flutterTts.setPitch(1.0);
  //   await flutterTts.speak('You choose the ' + select);
  //   // Provide feedback to the user and prompt them to record again
  // }

  Future<void> _speakOptions(option) async {
    if (language) {
      await flutterTts.setLanguage('en-US');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(option['en']);
    } else {
      await flutterTts.setLanguage('ar-AR');
      await flutterTts
          .setSpeechRate(0.25); // Set the speech rate (adjust as needed)
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(option['ar']);
    }
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

              List<String> words = recognizedText.split(' ');
              print(StringSimilarity.compareTwoStrings("اثنين", "اثنان"));
              // Iterate through the words to find a number from 1 to 5
              for (String word in words) {
                if (word == 'one' ||
                    word == 'won' ||
                    word == '1' ||
                    word == 'won' ||
                    word == 'wan' ||
                    StringSimilarity.compareTwoStrings(word, "واحد") >= 0.5) {
                  number = 1;
                  break;
                } else if (word == 'two' ||
                    word == '2' ||
                    word == 'to' ||
                    word == 'too' ||
                    StringSimilarity.compareTwoStrings(word, "اثنان") >= 0.5) {
                  number = 2;
                  break;
                } else if (word == 'three' ||
                    StringSimilarity.compareTwoStrings(word, "ثلاثة") >= 0.5 ||
                    word == 'tree' ||
                    word == 'thre' ||
                    word == '3') {
                  number = 3;
                  break;
                } else if (StringSimilarity.compareTwoStrings(word, "اربعة") >=
                        0.5 ||
                    word == 'four' ||
                    word == 'for' ||
                    word == '4') {
                  number = 4;
                  break;
                } else if (word == 'five' ||
                    word == 'hive' ||
                    word == '5' ||
                    word == 'vive') {
                  number = 5;
                  break;
                }
              }

              if (number == 1) {
                _speakOptions({
                  'en': 'You choose the Color Recognition',
                  'ar': 'لقد قمت بإختيار التعرف على اللون في الصورة '
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // Testscreen(def: widget.def1)
                      builder: (context) => DefaultScreen(
                            lang: (BlocProvider.of<LanguageCubit>(context)
                                        .language1 ==
                                    'en')
                                ? true
                                : false,
                            title: {
                              'en': localizedStrings['en']!['title'][0],
                              'ar': localizedStrings['ar']!['title'][0]
                            },
                          )),
                );
              } else if (number == 2) {
                _speakOptions({
                  'en': 'You choose the Text Extraction',
                  'ar': 'لقد قمت بإختيار إستخراج النص من الصورة '
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // Testscreen(def: widget.def1)
                      builder: (context) => DefaultScreen(
                            lang: (BlocProvider.of<LanguageCubit>(context)
                                        .language1 ==
                                    'en')
                                ? true
                                : false,
                            title: {
                              'en': localizedStrings['en']!['title'][1],
                              'ar': localizedStrings['ar']!['title'][1]
                            },
                          )),
                );
              } else if (number == 3) {
                _speakOptions({
                  'en': 'You choose the Image Caption',
                  'ar': 'لقد قمت بإختيار وصف الصورة '
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      // Testscreen(def: widget.def1)
                      builder: (context) => DefaultScreen(
                            lang: (BlocProvider.of<LanguageCubit>(context)
                                        .language1 ==
                                    'en')
                                ? true
                                : false,
                            title: {
                              'en': localizedStrings['en']!['title'][2],
                              'ar': localizedStrings['ar']!['title'][2]
                            },
                          )),
                );
              } else if (number == 4) {
                _speakOptions({
                  'ar':
                      'من فضلك قم بالإختيار , 1 اذا كنت تريد التعرف على اللون , 2 اذا كنت تريد استخراج النص من الصورة , 3 اذا كنت تريد وصف الصورة , 4 اذا كنت تريد اعادة هذه التعليمات مرة أخرى',
                  'en':
                      'Please select an option: 1 for color recognition, 2 for text extraction , 3 for Image Caption, 4 if you want me to repeat'
                });
              } else {
                _speakOptions({
                  'en': 'Sorry , I didn' 't understand please try again  ',
                  'ar': 'نأسف لم نفهم اختيارك يرجى المحاولة مرة أخرى لاحقا '
                });
              }
              number = -1;
              cubit.stopListening();
            } else {
              cubit.startListening(language);
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
