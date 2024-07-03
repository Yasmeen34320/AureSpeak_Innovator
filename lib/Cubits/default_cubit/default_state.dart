abstract class DefaultState {}

class DefaultInitialState extends DefaultState {}

class DefaultSecondInitialState extends DefaultState {}

class DefaultDisplayState extends DefaultState {
  String data;
  DefaultDisplayState({required this.data});
}

class DefaultLoadingState extends DefaultState {}

class DefaultSuccessState extends DefaultState {
  String data;
  String? lang;
  DefaultSuccessState({required this.data, this.lang});
}

class DefaultFailureState extends DefaultState {}
