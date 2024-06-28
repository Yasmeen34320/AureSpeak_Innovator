import 'package:flutter/material.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final FlutterTts flutterTts = FlutterTts();

  final List<PageViewModel> pages = [
    PageViewModel(
      title: 'About App',
      body:
          '''AuraSpeak Innovator is a transformative tool for the visually impaired, converting visual information into auditory output and providing educational support. It employs ML models for object recognition, text extraction, and engaging games to enhance learning and cognitive skills.''',
      image: Center(
        child: Lottie.asset('lib/assest/Animation/testt3.json'), // test3
      ),
    ),
    PageViewModel(
      title: 'Color Recognition Assist',
      body:
          '''AuraSpeak Innovator helps children and visually impaired individuals recognize and learn colors by identifying and highlighting the largest color object in the image.''',
      image: Center(
        child: Lottie.asset('lib/assest/Animation/ccc.json'),
      ),
    ),
    PageViewModel(
      title: 'Text Extraction Assist',
      body:
          '''AuraSpeak Innovator helps children in developing reading skills and aids visually impaired users by converting text from images into audible sound.''',
      image: Center(
        child: Lottie.asset('lib/assest/Animation/text_extracion.json'),
      ),
    ),
    PageViewModel(
      title: 'Image Caption Assist',
      body:
          '''AuraSpeak Innovator provides descriptive captions for images, benefiting visually impaired individuals by enhancing their understanding of image content and serving as an educational tool for children.''',
      image: Center(
        child: Lottie.asset('lib/assest/Animation/TEST1.json'),
      ),
    ),
  ];

  final List<String> speechTexts = [
    // It employs ML models for object recognition, text extraction, and engaging games to enhance learning and cognitive skills.
    "Welcome to our app. AuraSpeak Innovator is a transformative tool for the visually impaired, converting visual information into auditory output and providing educational support.we also provide speech recognition to help blind people interact with the app. Please listen to the instructions on each screen carefully. by select option 4, say 'choose 4' or any similar phrase.",
    "Color Recognition Assist: AuraSpeak Innovator identifies and highlights the largest color object in an image.",
    "Text Extraction Assist: AuraSpeak Innovator converts text from images into audible sound.",
    "Image Caption Assist: AuraSpeak Innovator provides descriptive captions for images."
  ];

  @override
  void initState() {
    super.initState();
    print('in the init');

    _speakPage(0); // Speak the text of the first page initially
  }

  Future<void> _speakPage(int index) async {
    await flutterTts.setLanguage('en-US');

    await flutterTts.setSpeechRate(0.25);
    await flutterTts.speak(speechTexts[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(10, 10),
            color: Colors.grey,
            activeSize: Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done: const Text(
            'Done',
            style: TextStyle(fontSize: 18),
          ),
          showSkipButton: true,
          skip: const Text(
            'Skip',
            style: TextStyle(fontSize: 18),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 18,
          ),
          onDone: () => onDone(context),
          onChange: (index) => _speakPage(index),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  void onDone(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => DetailsScreen(lang1: true)));
  }
}
