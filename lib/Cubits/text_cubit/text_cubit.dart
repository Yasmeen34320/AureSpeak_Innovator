import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:grd_projecttt/Cubits/text_cubit/text_state.dart';

class TextCubit extends Cubit<TextState> {
  TextCubit() : super(TextInitialState());
  String? data;
  void getInitial(int num) {
    if (num == 1)
      emit(TextInitialState());
    else
      emit(TextSecondInitialState());
  }

  void displayText(String data) {
    emit(TextDisplayState(data: data));
  }

  void getText(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg");
    emit(TextLoadingState());
    try {
      var request = http.MultipartRequest(
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2
        Uri.parse('http://192.168.1.7:8000/api/perform_ocr/$language'),
      );
      request.files.add(http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.png',
      ));
      //  print("$imageFile" + "dffffffffff");
      var response = await request.send();
      print("${response.statusCode} fghfhfgh");
      if (response.statusCode == 200) {
        data = await response.stream.bytesToString();

        // Remove the extra quotes
        String cleanedData = data!.replaceAll('"', '');

        data = cleanedData.replaceAll('\\n', ' ');
        print(data);
        print(cleanedData);
        // Convert the cleaned string to a list of strings
        // data = cleanedData;
        // final translatedText = (await translator.translate(data, to: 'ar'));
        // print(translatedText);
        // data1 = translatedText.text;
        // print(data1);
        print('OCR Result: $data');
        emit(TextSuccessState(data: data!));
      } else {
        emit(TextFailureState());
        print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      emit(TextFailureState());
    }
  }
}
