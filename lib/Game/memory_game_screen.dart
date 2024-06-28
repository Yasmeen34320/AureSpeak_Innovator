import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts for speech synthesis
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/default_screen.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Shared/info_card.dart';
import 'package:grd_projecttt/Game/game_utils.dart';

class HomeScreen extends StatefulWidget {
  final String? lang1;
  HomeScreen({super.key, required this.lang1});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle whiteText = TextStyle(color: Colors.white);
  Game _game = Game();
  int tries = 0;
  int score = 0;
  bool gameFinished = false;
  final FlutterTts flutterTts =
      FlutterTts(); // FlutterTts instance for speech synthesis

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      tries = 0;
      score = 0;
      gameFinished = false;
      _game.initGame();
      _game.shuffleLists();
    });
  }

  Future<void> playCorrectSound() async {
    // Play a correct sound effect and speak "Correct" using TTS
    try {
      await flutterTts.setVolume(1.0); // Max volume
      await flutterTts.speak('Correct');
    } catch (e) {
      print("Failed to speak: $e");
    }
  }

  void handleGameFinished() {
    setState(() {
      gameFinished = true;
    });
  }

  void navigateToPreviousScreen() {
    // Navigate to the previous screen (replace this with your actual navigation logic)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color(0xFFE55870)
      appBar: AppBar(
        title: Center(
          child: Text(
            localizedStrings[widget.lang1]!['options'][2],
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
              color: Color(0xFFFFB46A),
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
              color: Color(0xFFFFB46A),
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              ((ScreenUtil().orientation == Orientation.landscape))
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
          crossAxisAlignment:
              (ScreenUtil().orientation == Orientation.landscape)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: (ScreenUtil().orientation == Orientation.landscape)
                  ? 5.h
                  : 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info_card("Tries", "$tries"),
                info_card("Score", "$score"),
              ],
            ),
            SizedBox(
              height: ((ScreenUtil().orientation == Orientation.landscape))
                  ? 120.h
                  : 360.h,
              child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (ScreenUtil().orientation == Orientation.landscape)
                          ? 9
                          : 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                padding: EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (!gameFinished &&
                          _game.gameImg![index] == _game.hiddenCardpath) {
                        setState(() {
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                        });

                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            playCorrectSound();
                            setState(() async {
                              score += 100;
                              if (score == 400) {
                                await flutterTts.setVolume(1.0); // Max volume
                                await flutterTts.speak(
                                    'Well Done , you can play new game by reset');
                              }
                              _game.matchCheck.clear();
                            });
                            if (_game.cards_list.every(
                                (element) => element == _game.hiddenCardpath)) {
                              handleGameFinished();
                            }
                          } else {
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      width: (ScreenUtil().orientation == Orientation.landscape)
                          ? 20
                          : 100.w,
                      height:
                          ((ScreenUtil().orientation == Orientation.landscape))
                              ? 10.h
                              : 100.h,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFB46A),
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
                height: (ScreenUtil().orientation == Orientation.landscape)
                    ? 10.h
                    : 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startNewGame,
                  child: Text("Reset"),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: navigateToPreviousScreen,
                  child: Text("Leave"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
