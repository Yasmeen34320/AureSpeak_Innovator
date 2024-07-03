import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Game/Choices.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Game/color_matching_screen.dart';
import 'package:grd_projecttt/Game/math_game_screen.dart';
import 'package:grd_projecttt/Game/memory_game_screen.dart';
import 'package:lottie/lottie.dart';

List<dynamic> dataimage = [
  Lottie.asset(
    'lib/assest/Animation/test4.json',
    width: ((ScreenUtil().orientation == Orientation.landscape)) ? 60.w : 130.w,
    height: (ScreenUtil().orientation == Orientation.landscape)
        ? 60.h
        : 100.h, // Optional: Set the height
  ),
  Lottie.asset(
    'lib/assest/Animation/test2.json',
    width: ((ScreenUtil().orientation == Orientation.landscape)) ? 60.w : 130.w,
    height: (ScreenUtil().orientation == Orientation.landscape)
        ? 60.h
        : 100.h, // Optional: Set the height
  ),
  Lottie.asset(
    'lib/assest/Animation/test3.json',
    width: ((ScreenUtil().orientation == Orientation.landscape)) ? 60.w : 130.w,
    height: (ScreenUtil().orientation == Orientation.landscape)
        ? 60.h
        : 100.h, // Optional: Set the height
  ),
  Lottie.asset(
    'lib/assest/Animation/test.json',
    width: ((ScreenUtil().orientation == Orientation.landscape)) ? 60.w : 130.w,
    height: (ScreenUtil().orientation == Orientation.landscape)
        ? 60.h
        : 100.h, // Optional: Set the height
  ),
];

class GameOptionsScreen extends StatelessWidget {
  final String lang;

  GameOptionsScreen({required this.lang});
  @override
  Widget build(BuildContext context) {
    // if ((ScreenUtil().orientation == Orientation.landscape)) {
    //   AutoOrientation.landscapeAutoMode(); // Set the screen to landscape mode
    // } else {
    //   AutoOrientation.portraitAutoMode();
    // }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            (lang == 'en') ? 'Gaming Options' : 'الألعاب',
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
              color: Color(0xFF6b5ba0),
              weight: 0.8,
              size: (ScreenUtil().orientation == Orientation.landscape)
                  ? 18.sp
                  : 28.sp,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.games_outlined,
            color: Color(0xFF6b5ba0),
            weight: 0.8,
            size: (ScreenUtil().orientation == Orientation.landscape)
                ? 18.sp
                : 28.sp,
          ),
        ),
        backgroundColor: Colors.white,
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
              height:
                  (ScreenUtil().orientation == Orientation.landscape) ? 0 : 5.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Container(
                height: 900.h,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        ((ScreenUtil().orientation == Orientation.landscape))
                            ? 4
                            : 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GameOptionTile(
                      index: index,
                      lang: lang,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameOptionTile extends StatelessWidget {
  final int index;
  final String lang;
  GameOptionTile({required this.index, required this.lang});

  @override
  Widget build(BuildContext context) {
    List<dynamic> route = [
      MathGameScreen(
        lang1: lang,
      ),
      ColorMatchingScreen(
        lang1: lang,
      ),
      MemoryGameScreen(
        lang1: lang,
      ),
      ChoicesScreen(
        lang1: lang,
      )
    ];
    var screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              // Testscreen(def: widget.def1)
              builder: (context) => route[index]),
        );
      },
      child: Container(
        width: screenSize.width * 0.45,
        height: ((ScreenUtil().orientation == Orientation.landscape))
            ? screenSize.height * 0.4
            : screenSize.height * 0.3,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 250, 242, 237),
          boxShadow: [],
          border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(children: [
          SizedBox(
            height:
                ((ScreenUtil().orientation == Orientation.landscape)) ? 5 : 5,
          ),
          // expandeddddddddddddddddddddddd
          dataimage[index],
          SizedBox(
            height: ((ScreenUtil().orientation == Orientation.landscape))
                ? 20.h
                : 0,
          ),
          Flexible(
              child: Text(
            //"Using Camera",
            localizedStrings[lang]!['options'][index],
            // appLocalizations(context).option,
            style: GoogleFonts.nunito(
              fontSize: ((ScreenUtil().orientation == Orientation.landscape))
                  ? 9.sp
                  : 17.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ))
        ]),
      ),
    );
  }
}
