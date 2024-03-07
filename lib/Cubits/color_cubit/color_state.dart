abstract class ColorsState {}

class ColorsInitialState extends ColorsState {}

class ColorsSecondInitialState extends ColorsState {}

class ColorsDisplayState extends ColorsState {
  String data;
  ColorsDisplayState({required this.data});
}

class ColorsLoadingState extends ColorsState {}

class ColorsSuccessState extends ColorsState {
  String data;
  ColorsSuccessState({required this.data});
}

class ColorsFailureState extends ColorsState {}
