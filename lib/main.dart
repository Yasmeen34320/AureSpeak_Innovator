import 'package:flutter/material.dart';
import 'package:grd_projecttt/Cubits/color_cubit/color_cubit.dart';
import 'package:grd_projecttt/Cubits/language_cubit/language_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_cubit.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:grd_projecttt/Cubits/text_cubit/text_cubit.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:grd_projecttt/Screens/test_screen.dart';
import 'package:grd_projecttt/Shared/card_category.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grd_projecttt/test/m1.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

bool default1 = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextCubit>(create: (context) => TextCubit()),
        BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
        BlocProvider<ColorsCubit>(create: (context) => ColorsCubit()),
        BlocProvider<SpeechRecognitionCubit>(
            create: (context) => SpeechRecognitionCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
            //  CardCategory(
            //     Images: "lib/assest/color.jpg",
            //     TestName: "Color Recognition",
            //     brief:
            //         "involves the capability to identify and process colors within images or through the device's camera."),
            //    Testscreen(),
            // adb reverse tcp:8000 tcp:8000
            DetailsScreen(lang1: default1),
      ),
    );
  }
}
