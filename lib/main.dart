import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grd_projecttt/Cubits/language_cubit/language_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:grd_projecttt/Screens/on_boarding_screen.dart';
import 'package:grd_projecttt/Screens/deetails_games.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Game/color_matching_screen.dart';
import 'package:grd_projecttt/Game/math_game_screen.dart';
import 'package:grd_projecttt/Game/memory_game_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// bool show = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool show = prefs.getBool('ON_BORDING') ?? true;
  runApp(MyApp(
    show: show,
  ));
}

bool default1 = true;

class MyApp extends StatelessWidget {
  final bool show;
  const MyApp({super.key, required this.show});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
        BlocProvider<SpeechRecognitionCubit>(
            create: (context) => SpeechRecognitionCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AuraSpeak Innovator',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:
                // AnimatedSplashScreen(
                //   duration: 3000,
                //   splash: Image.asset(
                //     'lib/assest/logo.png',
                //     fit: BoxFit.cover,
                //     // Adjust the height as needed
                //   ),
                //   splashIconSize: 100,
                //   nextScreen: show ? IntroScreen() : DetailsScreen(lang1: default1),
                //   splashTransition: SplashTransition.fadeTransition,
                // ),

                //  CardCategory(
                //     Images: "lib/assest/color.jpg",
                //     TestName: "Color Recognition",
                //     brief:
                //         "involves the capability to identify and process colors within images or through the device's camera."),
                //    Testscreen(),
                // adb reverse tcp:8000 tcp:8000
                show ? IntroScreen() : DetailsScreen(lang1: default1),

            //GameScreen(),/////////[==[m,ji]]
            //  MathGameScreen(),
            //HomeScreen(),
            // GameOptionsScreen(lang: 'en'),
          );
        },
      ),
    );
  }
}
