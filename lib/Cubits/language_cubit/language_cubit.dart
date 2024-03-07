import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_projecttt/Cubits/language_cubit/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(EnglishState());
  String language1 = 'en';
  void getLanguage(String language) {
    if (language == 'en') {
      language1 = 'en';
      emit(EnglishState());
    } else {
      language1 = 'ar';
      emit(ArabicState());
    }
  }
}
