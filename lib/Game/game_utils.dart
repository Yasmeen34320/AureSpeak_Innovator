import 'dart:math';
import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue,
  ];
  final String hiddenCardpath = "lib/assest/images_memory/hidden.png";
  List<String> cards_list = [
    "lib/assest/images_memory/circle.png",
    "lib/assest/images_memory/triangle.png",
    "lib/assest/images_memory/circle.png",
    "lib/assest/images_memory/heart.png",
    "lib/assest/images_memory/star.png",
    "lib/assest/images_memory/triangle.png",
    "lib/assest/images_memory/star.png",
    "lib/assest/images_memory/heart.png",
  ];
  final int cardCount = 8;
  List<Map<int, String>> matchCheck = [];

  // Constructor
  Game() {
    // Shuffle initial lists upon object creation
    shuffleLists();
  }

  // Method to shuffle both cards and cards_list
  void shuffleLists() {
    cards.shuffle(Random());
    cards_list.shuffle(Random());
  }

  // Methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
