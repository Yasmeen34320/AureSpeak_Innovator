import 'dart:io';
import 'package:grd_projecttt/Cubits/color_cubit/color_state.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

class ColorsCubit extends Cubit<ColorsState> {
  ColorsCubit() : super(ColorsInitialState());
  String? data;
  void getInitial(int num) {
    if (num == 1)
      emit(ColorsInitialState());
    else
      emit(ColorsSecondInitialState());
  }

  void displayColors(String data) {
    emit(ColorsDisplayState(data: data));
  }

  void getColors(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg111111");

    emit(ColorsLoadingState());
    print("wt is wrong1");
    try {
      var request = http.MultipartRequest(
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2
        Uri.parse('http://192.168.1.7:8000/api/perform_color'),
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
        // final translatedColors = (await translator.translate(data, to: 'ar'));
        // print(translatedColors);
        // data1 = translatedColors.Colors;
        // print(data1);
        print('OCR Result: $data');
        emit(ColorsSuccessState(data: data!));
      } else {
        emit(ColorsFailureState());
        print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      emit(ColorsFailureState());
    }
  }
}
