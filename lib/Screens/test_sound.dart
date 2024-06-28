import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MySoundButton extends StatelessWidget {
  AudioPlayer _player = AudioPlayer();

  void playSoundEffect() async {
    try {
      // Use the AudioPlayer to play the specified audio file
      await _player.play(
          AssetSource('lib/assest/audio/+-++.mp3')); // Adjust path accordingly
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Sound Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: playSoundEffect,
          child: Text('Play Sound'),
        ),
      ),
    );
  }
}
