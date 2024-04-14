enum SpeechRecognitionState { initial, listening, stopped, error }

abstract class SpeechState {}

class SpeechInitialState extends SpeechState {}

class SpeechListeningState extends SpeechState {}

class SpeechStoppedState extends SpeechState {}

class SpeechErrorState extends SpeechState {}
