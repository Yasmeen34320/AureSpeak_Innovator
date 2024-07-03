import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:grd_projecttt/Cubits/default_cubit/default_state.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

import 'package:bloc/bloc.dart';

class DefaultCubit extends Cubit<DefaultState> {
  DefaultCubit() : super(DefaultInitialState());
  String? data;
  void getInitial(int num) {
    if (num == 1)
      emit(DefaultInitialState());
    else
      emit(DefaultSecondInitialState());
  }

  void displayText(String data) {
    emit(DefaultDisplayState(data: data));
  }

  // get color functionnn
  void getColors(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg111111");

    emit(DefaultLoadingState());
    print("wt is wrong1");
    try {
      var request = http.MultipartRequest(
        // https://colors-ot12.onrender.com
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2 // https://pdnfbn1b-8000.euw.devtunnels.ms/
        Uri.parse('https://jvbvrw73-8000.euw.devtunnels.ms//api/perform_color'),
        // api/image_caption ,, perform_color
      );
      // Determine the MIME type based on the file extension
      String? mimeType = lookupMimeType(imageFile.path);

      // If mimeType is null or not found, default to 'image/jpeg'
      mimeType ??= 'image/jpeg';
      // Determine the file extension based on the MIME type
      String fileExtension = mimeType.split('/').last;

      // Construct the filename with the determined extension
      String filename = 'image.$fileExtension';
      request.files.add(http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: filename,
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
        emit(DefaultSuccessState(data: data!));
      } else {
        emit(DefaultFailureState());
        print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      emit(DefaultFailureState());
    }
  }

  /// get image function

  void getCaption(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg111111");

    emit(DefaultLoadingState());
    print("wt is wrong1sd");
    try {
      /////////////////////////////////
      // final imagePath = imageFile.path;
      print('in the tryyyyyyyyyyyy');

      // ///////////////////////////
      var request = http.MultipartRequest(
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2 , http://192.168.1.7:8003
        Uri.parse('https://jvbvrw73-8000.euw.devtunnels.ms//api/image_caption'),
        // api/image_caption ,, perform_color
      );
      request.files.add(http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.png',
      ));
      print("$imageFile" + "dffffffffff");
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
        emit(DefaultSuccessState(data: data!));
      } else {
        emit(DefaultFailureState());
        //   print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('error:  :  $error');
      emit(DefaultFailureState());
    }
  }

  // get text
  void getText(File imageFile, String language) async {
    print("wrongggggggggggggggggggggggggggggggg");
    emit(DefaultLoadingState());
    try {
      var request = http.MultipartRequest(
        'PUT', // 127.0.0.1 (windows) ,, 192.168.1.7 , 10.0.2.2,http://192.168.1.7:8003
        Uri.parse(// https://pdnfbn1b-8000.euw.devtunnels.ms/api/perform_ocr/en
            // https://jvbvrw73-8000.euw.devtunnels.ms/
            'https://jvbvrw73-8000.euw.devtunnels.ms//api/perform_ocr/$language'),
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
        var responseData = await response.stream.bytesToString(); // data
        var jsonResponse = jsonDecode(responseData);
        var data = jsonResponse['extracted_text'];
        var detectedLanguage = jsonResponse['detected_language'];
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
        emit(DefaultSuccessState(data: data!, lang: detectedLanguage));
      } else {
        emit(DefaultFailureState());
        print('Error cvcvcv: ${response.reasonPhrase}');
      }
    } catch (error) {
      emit(DefaultFailureState());
    }
  }
}
