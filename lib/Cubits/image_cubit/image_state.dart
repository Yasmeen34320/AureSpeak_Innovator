abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageSecondInitialState extends ImageState {}

class ImageDisplayState extends ImageState {
  String data;
  ImageDisplayState({required this.data});
}

class ImageLoadingState extends ImageState {}

class ImageSuccessState extends ImageState {
  String data;
  ImageSuccessState({required this.data});
}

class ImageFailureState extends ImageState {}
