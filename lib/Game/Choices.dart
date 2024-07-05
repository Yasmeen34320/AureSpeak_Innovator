import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:grd_projecttt/Screens/deetails_games.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:auto_orientation/auto_orientation.dart';

class ChoicesScreen extends StatefulWidget {
  final String? lang1;
  ChoicesScreen({super.key, required this.lang1});
  @override
  _ChoicesScreenState createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin
    implements TickerProvider {
  int index = 0;
  final FlutterTts flutterTts = FlutterTts();
  void _speak(String text) async {
    print('in the speak');
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.setVolume(1.0); // Max volume
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    questions.shuffle();
    super.initState();
    questionsar.shuffle();

    WidgetsBinding.instance.addObserver(this);
    AutoOrientation.landscapeAutoMode(); // Set the screen to landscape mode
  }

  @override
  void dispose() {
    AutoOrientation.fullAutoMode(); // Set the screen to landscape mode

    // Reset to auto mode when leaving the screen
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  int score = 0;
  // var player = AudioCache();
  var correct = [
    'Elephant',
    'Plane',
    'Orange',
    'Pen',
    'Gift',
    'Planet',
    'Bee',
    'Cat',
    'Banana',
    'Car',
    'Football',
    'Tree',
    'Book',
    'Fish',
    'Doll',
    'Sun',
    'Cake',
    'Hammer',
  ];
  var questions = [
    {
      'image': 'lib/assest/elephant.png',
      'answers': ['Elephant', 'Giraffe', 'Butterfly', 'Lion'],
      'correct': 'Elephant',
    },
    {
      'image': 'lib/assest/plane.png',
      'answers': ['Car', 'Plane', 'Bike', 'Boat'],
      'correct': 'Plane',
    },
    {
      'image': 'lib/assest/orange.png',
      'answers': ['Apple', 'Orange', 'Pomegranate', 'Banana'],
      'correct': 'Orange',
    },
    {
      'image': 'lib/assest/pen.png',
      'answers': ['Brush', 'Pen', 'Ruler', 'Book'],
      'correct': 'Pen',
    },
    {
      'image': 'lib/assest/present.png',
      'answers': ['Gift', 'Clock', 'Book', 'Table'],
      'correct': 'Gift',
    },
    {
      'image': 'lib/assest/planet.png',
      'answers': ['Moon', 'Planet', 'Ship', 'Sun'],
      'correct': 'Planet',
    },
    {
      'image': 'lib/assest/bee.png',
      'answers': ['Bird', 'Butterfly', 'Ant', 'Bee'],
      'correct': 'Bee',
    },
    {
      'image': 'lib/assest/cat.jpg',
      'answers': ['Cat', 'Dog', 'Rabbit', 'Mouse'],
      'correct': 'Cat',
    },
    {
      'image': 'lib/assest/banana.jpg',
      'answers': ['Apple', 'Banana', 'Pear', 'Orange'],
      'correct': 'Banana',
    },
    {
      'image': 'lib/assest/car.jpg',
      'answers': ['Car', 'Bike', 'Bus', 'Truck'],
      'correct': 'Car',
    },
    {
      'image': 'lib/assest/football.jpg',
      'answers': ['Football', 'Tennis', 'Golf', 'Baseball'],
      'correct': 'Football',
    },
    {
      'image': 'lib/assest/tree.jpg',
      'answers': ['Rose', 'Plant', 'Tree', 'Grass'],
      'correct': 'Tree',
    },
    {
      'image': 'lib/assest/book.jpg',
      'answers': ['Magazine', 'Book', 'Newspaper', 'Notebook'],
      'correct': 'Book',
    },
    {
      'image': 'lib/assest/fish.jpg',
      'answers': ['Turtle', 'Dolphin', 'Whale', 'Fish'],
      'correct': 'Fish',
    },
    {
      'image': 'lib/assest/doll.jpg',
      'answers': ['Car', 'Robot', 'Doll', 'Bear'],
      'correct': 'Doll',
    },
    {
      'image': 'lib/assest/sun.jpg',
      'answers': ['Sun', 'Moon', 'Star', 'Planet'],
      'correct': 'Sun',
    },
    {
      'image': 'lib/assest/cake.jpg',
      'answers': ['Cake', 'Biscuit', 'Pastry', 'Chocolate'],
      'correct': 'Cake',
    },
    {
      'image': 'lib/assest/hammer.jpg',
      'answers': ['Screwdriver', 'Hammer', 'Stick', 'Cake'],
      'correct': 'Hammer',
    },
  ];

  // Stop confetti after some time (adjust as needed)
  // Future.delayed(Duration(seconds: 2), () {
  //   _confettiController.stop();
  // });
  var correctar = [
    'فيل',
    'طائرة',
    'برتقالة',
    'قلم',
    'هدية',
    'كوكب',
    'نحلة',
    'قط',
    'موزة',
    'سيارة',
    'كرة القدم',
    'شجرة',
    'كتاب',
    'سمكة',
    'دمية',
    'شمس',
    'كعكة',
    'مطرقة',
  ];

  var questionsar = [
    {
      'image': 'lib/assest/elephant.png',
      'answers': ['فيل', 'زرافة', 'فراشة', 'أسد'],
      'correct': 'فيل',
    },
    {
      'image': 'lib/assest/plane.png',
      'answers': ['سيارة', 'طائرة', 'دراجة', 'قارب'],
      'correct': 'طائرة',
    },
    {
      'image': 'lib/assest/orange.png',
      'answers': ['تفاحة', 'برتقالة', 'رمانة', 'موزة'],
      'correct': 'برتقالة',
    },
    {
      'image': 'lib/assest/pen.png',
      'answers': ['فرشاة', 'قلم', 'مسطرة', 'كتاب'],
      'correct': 'قلم',
    },
    {
      'image': 'lib/assest/present.png',
      'answers': ['هدية', 'ساعة', 'كتاب', 'طاولة'],
      'correct': 'هدية',
    },
    {
      'image': 'lib/assest/planet.png',
      'answers': ['قمر', 'كوكب', 'سفينة', 'شمس'],
      'correct': 'كوكب',
    },
    {
      'image': 'lib/assest/bee.png',
      'answers': ['طائر', 'فراشة', 'نملة', 'نحلة'],
      'correct': 'نحلة',
    },
    {
      'image': 'lib/assest/cat.jpg',
      'answers': ['قط', 'كلب', 'أرنب', 'فأر'],
      'correct': 'قط',
    },
    {
      'image': 'lib/assest/banana.jpg',
      'answers': ['تفاحة', 'موز', 'كمثرى', 'برتقالة'],
      'correct': 'موز',
    },
    {
      'image': 'lib/assest/car.jpg',
      'answers': ['سيارة', 'دراجة', 'حافلة', 'شاحنة'],
      'correct': 'سيارة',
    },
    {
      'image': 'lib/assest/football.jpg',
      'answers': ['كرة القدم', 'تنس', 'غولف', 'بيسبول'],
      'correct': 'كرة القدم',
    },
    {
      'image': 'lib/assest/tree.jpg',
      'answers': ['وردة', 'نبات', 'شجرة', 'عشب'],
      'correct': 'شجرة',
    },
    {
      'image': 'lib/assest/book.jpg',
      'answers': ['مجلة', 'كتب', 'صحيفة', 'دفتر'],
      'correct': 'كتب',
    },
    {
      'image': 'lib/assest/fish.jpg',
      'answers': ['سلحفاة', 'دلفين', 'حوت', 'سمكة'],
      'correct': 'سمكة',
    },
    {
      'image': 'lib/assest/doll.jpg',
      'answers': ['سيارة', 'روبوت', 'دمية', 'دب'],
      'correct': 'دمية',
    },
    {
      'image': 'lib/assest/sun.jpg',
      'answers': ['شمس', 'قمر', 'نجمة', 'كوكب'],
      'correct': 'شمس',
    },
    {
      'image': 'lib/assest/cake.jpg',
      'answers': ['كعكة', 'بسكويت', 'معجنات', 'شيكولاتة'],
      'correct': 'كعكة',
    },
    {
      'image': 'lib/assest/hammer.jpg',
      'answers': ['مفك', 'مطرقة', 'عصا', 'كعكة'],
      'correct': 'مطرقة',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.lang1 == 'en' ? 'Score:$score' : 'النتيجة $score',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  Text(
                    widget.lang1 == 'en'
                        ? 'Choose The Correct Answer'
                        : 'قم بإختيار الإجابة الصحيحة',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 60,
                        child: Image(image: AssetImage('lib/assest/x.png'))),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image(
                        image: AssetImage((widget.lang1 == 'en'
                            ? questions[index]['image']
                            : questionsar[index]['image']) as String)),
                    radius: 110,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...(((widget.lang1 == 'en')
                          ? questions[index]['answers']!
                          : questionsar[index]['answers']!) as List<String>)
                      .map((answer) {
                    return ElevatedButton(
                      onPressed: () {
                        if (answer ==
                            ((widget.lang1 == 'en')
                                ? questions[index]['correct']!
                                : questionsar[index]['correct']!)) {
                          // player.play('win.mp3');
                          // Alert(
                          //   context: context,
                          //   title: "Well Done",
                          //   desc: "You have moved to the next level.",
                          // ).show();
                          print('correct');
                          if (widget.lang1 == 'en')
                            _speak('Correct');
                          else
                            _speak('صحيح');
                          setState(() {
                            print('$index ${correct.length}');
                            if (index < correct.length - 1)
                              index++;
                            else {
                              if (widget.lang1 == 'en')
                                _speak('Well Done finishing the test');
                              else
                                _speak('لقد احسنت بإجتياز الاختبار');

                              Navigator.of(context).pop();
                            }

                            score += 10;
                          });
                        } else {
                          if (widget.lang1 == 'en')
                            _speak('Try again!');
                          else
                            _speak('حاول مرة أخرى ');
                          // player.play('fail.mp3');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          answer,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      // color: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                      // splashColor: Colors.black26,
                      // focusColor: Colors.green,
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
