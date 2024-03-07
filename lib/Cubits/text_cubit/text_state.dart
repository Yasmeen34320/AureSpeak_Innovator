abstract class TextState {}

class TextInitialState extends TextState {}

class TextSecondInitialState extends TextState {}

class TextDisplayState extends TextState {
  String data;
  TextDisplayState({required this.data});
}

class TextLoadingState extends TextState {}

class TextSuccessState extends TextState {
  String data;
  TextSuccessState({required this.data});
}

class TextFailureState extends TextState {}
