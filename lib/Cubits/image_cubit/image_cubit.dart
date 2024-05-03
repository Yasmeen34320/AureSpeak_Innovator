import 'dart:io';

import 'package:grd_projecttt/Cubits/image_cubit/image_state.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitialState());
  String? data;
  void getInitial(int num) {
    if (num == 1)
      emit(ImageInitialState());
    else
      emit(ImageSecondInitialState());
  }

  void displayCaption(String data) {
    emit(ImageDisplayState(data: data));
  }

  void getCaption(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg111111");

    emit(ImageLoadingState());
    print("wt is wrong1");
    try {
      var request = http.MultipartRequest(
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2 , http://192.168.1.7:8003
        Uri.parse('https://pdnfbn1b-8000.euw.devtunnels.ms/api/image_caption'),
        // api/image_caption ,, perform_color
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
        emit(ImageSuccessState(data: data!));
      } else {
        emit(ImageFailureState());
        print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      emit(ImageFailureState());
    }
  }
}
