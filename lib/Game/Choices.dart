import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:grd_projecttt/Screens/deetails_games.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:animated_background/animated_background.dart';
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
    await flutterTts.setVolume(1.0); // Max volume
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    questions.shuffle();
    super.initState();
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
                    'Score:$score',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  Text(
                    'Choose The Correct Answer',
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
                        image: AssetImage(questions[index]['image'] as String)),
                    radius: 110,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...(questions[index]['answers'] as List<String>)
                      .map((answer) {
                    return ElevatedButton(
                      onPressed: () {
                        if (answer == questions[index]['correct']) {
                          // player.play('win.mp3');
                          // Alert(
                          //   context: context,
                          //   title: "Well Done",
                          //   desc: "You have moved to the next level.",
                          // ).show();
                          print('correct');
                          setState(() {
                            _speak('Correct');
                            print('$index ${correct.length}');
                            if (index < correct.length - 1)
                              index++;
                            else
                              Navigator.of(context).pop();

                            score += 10;
                          });
                        } else {
                          _speak('Try again!');

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
