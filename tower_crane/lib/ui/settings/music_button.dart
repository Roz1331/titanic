import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicButton extends StatefulWidget {
  @override
  _MusicButtonState createState() => _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  bool isPlaying = false;

  bool isOpened = false;

  String playerStatusText(){
    if (!isOpened){
      return "Задать настроение";
    }
    else if (isPlaying){
      return "Давайте помолчим";
    }
    else {
      return "Продолжить грустить";
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        playerStatusText(),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        if (!isOpened){
          assetsAudioPlayer.open(
              Audio(
                "assets/Titanic.mp3",
              ),
              loopMode: LoopMode.single,
              autoStart: true,
            );
          setState(() {
            isOpened = true;
            isPlaying = true;
          });
        }
        else if (isPlaying) {
          assetsAudioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
        else{
          assetsAudioPlayer.play();
          setState(() {
            isPlaying = true;
          });
        }
      },
      icon: Icon(
        Icons.music_note,
        color: Colors.black,
      ),
    );
  }
}
