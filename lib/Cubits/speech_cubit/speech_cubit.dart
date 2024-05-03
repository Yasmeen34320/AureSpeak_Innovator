import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:grd_projecttt/Cubits/speech_cubit/speech_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionCubit extends Cubit<SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  String _recognizedText = '';

  SpeechRecognitionCubit() : super(SpeechInitialState());

  Future<void> initializeSpeech() async {
    if (await _speech.initialize()) {
      print("initilll");
      emit(SpeechInitialState());
    } else {
      emit(SpeechErrorState());
    }
  }

  Future<void> startListening(bool lang) async {
    if (!(state is SpeechListeningState)) {
      emit(SpeechListeningState());
      _recognizedText = '';
      String localeId = lang ? 'en-US' : 'ar';
// Reset recognized text
      _speech.listen(
        localeId: localeId,
        onResult: (result) {
          print(result.recognizedWords + "hhh+++++++++++");
          _recognizedText = result.recognizedWords;
        },
        onSoundLevelChange: (level) {},
      );
    }
  }

  void stopListening() {
    _speech.stop();
    emit(SpeechStoppedState());
  }

  String get recognizedText => _recognizedText;
  set recognizedText(String value) {
    _recognizedText = value;
  }
}
