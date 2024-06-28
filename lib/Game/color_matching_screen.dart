import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';

class GameScreen extends StatefulWidget {
  final String lang1;
  GameScreen({super.key, required this.lang1});
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer _player = AudioPlayer();
  final Random random = Random();

  late int index1;
  late Color color;
  Map<String, Color> colorMap = {
    // 'Red': Colors.red,
    // 'Green': Colors.green,
    // 'Blue': Colors.blue,
    // 'Yellow': Colors.yellow,
    // 'Purple': Colors.purple,
    // 'Orange': Colors.orange,
    // 'Pink': Colors.pink,
    // 'Cyan': Colors.cyan,
    // 'Brown': Colors.brown,
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
    'Purple': Colors.purple,
    'Orange': Colors.orange,
    'Pink': Colors.pink,
    'Cyan': Colors.cyan,
    'Teal': Colors.teal,
    'Lime': Colors.lime,
    'Indigo': Colors.indigo,
    'Amber': Colors.amber,
    'Brown': Colors.brown,
    'Grey': Colors.grey,
    'Black': Colors.black,
    'White': Colors.white,
    'Turquoise': Color(0xFF40E0D0),
    'Gold': Color(0xFFFFD700),
    'Silver': Color(0xFFC0C0C0),
    'Olive': Color(0xFF808000),
    'Maroon': Color(0xFF800000),
    'Navy': Color(0xFF000080),
    'Plum': Color(0xFFDDA0DD),
    'Salmon': Color(0xFFFA8072),
    'Aqua': Color(0xFF00FFFF),
  };

  Set<String> correctMatches = Set<String>();
  List<String> colorsList = [], colorsList1 = [], colors = [];

  @override
  void initState() {
    super.initState();

    colorsList1 = colorMap.keys.toList();
    colorsList1.shuffle(Random());

    colorsList = colorsList1.take(8).toList();
    colors = colorsList1.take(8).toList();
    index1 = random.nextInt(colorsList.length);
    color = colorMap[colorsList[index1]]!;
  }

  void _speak(String text) async {
    await flutterTts.setVolume(1.0); // Max volume
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _player.dispose(); // Dispose the audio player
    super.dispose();
  }

  void checkAllColorsMatched() {
    if (colorsList.length == 0) {
      _speak('Well Done finishing the test');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            localizedStrings[widget.lang1]!['options'][1],
            style: GoogleFonts.nunito(
              fontSize: (ScreenUtil().orientation == Orientation.landscape)
                  ? 15.sp
                  : 22.sp,
              color: Color.fromRGBO(7, 7, 7, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.games_outlined,
              color: color,
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: color,
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: colorsList.map((colorName) {
                return Draggable<Color>(
                  data: colorMap[colorName]!,
                  child: ColorCircle(color: colorMap[colorName]!),
                  feedback: ColorCircle(
                      color: colorMap[colorName]!, isDragging: true),
                  childWhenDragging: ColorCircle(color: Colors.grey),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 20,
              children: colors.map((colorName) {
                return DragTarget<Color>(
                  builder: (context, candidateData, rejectedData) {
                    bool isCorrect = correctMatches.contains(colorName);
                    return Container(
                      padding: EdgeInsets.all(3.0),
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isCorrect ? colorMap[colorName] : Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          colorName,
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: isCorrect ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  onAccept: (receivedColor) {
                    setState(() {
                      if (receivedColor == colorMap[colorName]) {
                        _speak('Correct! ${colorName}');
                        correctMatches.add(colorName);
                        colorsList.remove(colorName);
                        checkAllColorsMatched();
                      } else {
                        _speak('Try again!');
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  final Color color;
  final bool isDragging;

  ColorCircle({required this.color, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDragging ? 50 : 60,
      height: isDragging ? 50 : 60,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
