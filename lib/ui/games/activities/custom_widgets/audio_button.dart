import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioButton extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> soundFiles;  // Change to a list of sound files

  AudioButton({
    super.key, required this.soundFiles,
  });

  void _playSounds() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    double volume = _prefs.getInt('efeitos')!.toDouble() / 10;

    // Loop through the list of sound files
    for (var sound in soundFiles) {
      await audioPlayer.setVolume(volume);
      await audioPlayer.play(AssetSource('audio/$sound')); // Play each sound
      await audioPlayer.onPlayerComplete.first; // Wait until the current sound finishes
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _playSounds,  // Play all sounds when pressed
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
      ),
      child: SvgPicture.asset(
        'assets/imgs/speaker.svg',
        width: 90,
        height: 66,
      ),
    );
  }
}

