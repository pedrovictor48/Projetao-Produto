import 'package:audioplayers/audioplayers.dart';
import 'package:demo_app/ui/games/activities/custom_widgets/audio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:demo_app/services/services.dart";

class CountLettersBySound extends StatefulWidget {
  String storyId;
  int subStoryId;
  String activityId;
  String nextActivityId;

  CountLettersBySound({super.key,
                       required this.subStoryId,
                       required this.storyId,
                       this.activityId = "",
                       this.nextActivityId = ""
                      });

  @override
  _CountLettersBySoundState createState() => _CountLettersBySoundState();
}

class _CountLettersBySoundState extends State<CountLettersBySound> {
  TextEditingController controller = TextEditingController();

  static const textSize = 25.0;
  static const int textColor = 0xFF03BFE7;
  static const int borderColor = 0xFF012480;

  List<String> wordList = ['computador', 'bolo', 'casa'];

  String letter = 'C';

  late int letterCount;

  late final DateTime timeStartActivity; // Será utilizado para calcula tempo para o relatório.

  bool dialogShown = false; // Add a flag to check if the dialog has been shown
  bool nextActivityLoaded = false;
  bool isLoaded = false;
  bool isAnswerIncorrect = false;
  bool solvedActivity = false;

  List<String> questionText = [];        
  late List<String> audioList;

  TextSpan printedText = TextSpan();


  @override
  void initState() {
    super.initState();
    timeStartActivity = DateTime.now();

    if (widget.storyId != ""){
      fetchNextActivity(widget.storyId, widget.subStoryId).then((response) => {
        setState(() {        
          widget.nextActivityId = response;        
          nextActivityLoaded = true;
          var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.

          nextActivityLoaded = true;
        })
      });

    }else{}

    fetchActivity(http.Client(), widget.activityId).then((response) => {
      setState(() {
        String entireObject;        
        entireObject = response;
        Map activity = json.decode(entireObject);

        print(activity);

        wordList = activity["body"]["words"].cast<String>();
        letter = activity["body"]["letter"];

        audioList = ['word_sounds/${wordList[0]}.mp3', 'word_sounds/${wordList[1]}.mp3', 'word_sounds/${wordList[2]}.mp3'];

        letterCount = countLetterInList(wordList, letter);

        questionText.add("Conte quantos ");
        questionText.add(letter);
        questionText.add(" têm no áudio.");

        printedText = TextSpan(
          children: [
            WidgetSpan(
              child: GoldenTextSpecial(
                text: questionText[0],
                textSize: 20,
                // Adjust as needed
                borderColor: 0xFF012480,
                // Adjust as needed
                borderWidth: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: questionText[1],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Playpen-Sans', // Fixed font family
                fontWeight: FontWeight.bold,
              ), // Style for normal text
            ),
            WidgetSpan(
              child: GoldenTextSpecial(
                text: questionText[2],
                textSize: 20,
                // Adjust as needed
                borderColor: 0xFF012480,
                // Adjust as needed
                borderWidth: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      
        isLoaded = true;
      })
    });

  }

  void _playSounds(String sound) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? volumePref = _prefs.getInt('efeitos');
    double volume = (volumePref ?? 5).toDouble() / 10; // Default to 5 if null

    final AudioPlayer soundPlayer = AudioPlayer();

    try {
      await soundPlayer.setVolume(volume);
      await soundPlayer.play(AssetSource('audio/sound_effects/$sound')); // Play each sound
      await soundPlayer.onPlayerComplete.first; // Wait until the current sound finishes
    } finally {
      soundPlayer.dispose(); // Dispose of the player after sound finishes
    }
  }

  void checkAnswer() {
    String userAnswer = controller.text;

    if (userAnswer.isEmpty) {
    } else {
      int? answerAsInt = int.tryParse(userAnswer);

      if (answerAsInt == null) {
      } else if (isLoaded && answerAsInt == letterCount && !dialogShown) {
        setState(() {
          solvedActivity = true;
          isAnswerIncorrect = false;
          dialogShown = true; // Ensure the dialog is only shown once
          var activityDuration = DateTime.now().difference(timeStartActivity); // Mandar essa variável para o back do relatório.
        });
        _playSounds("act_end_sound.wav");
        Future.delayed(Duration(milliseconds: 500), () {
          // Replace with your navigation logic
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                currentScreen: CountLettersBySound(
                    subStoryId: widget.subStoryId, storyId: widget.storyId),
                story: widget.subStoryId != 0 ? true : false,
                storyId: widget.storyId,
                subStoryId: widget.subStoryId,
                nextActivityId: widget.nextActivityId,
                ctx: context,
              ); // Call your custom popup
            },
            barrierDismissible: false,
          );
        });
      } else {
        setState(() {
          _playSounds("wrong_sound.wav");
          isAnswerIncorrect = true; // Answer is incorrect, flash red
        });
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            isAnswerIncorrect = false; // Reset red flash
          });
        });
      }
    }
  }

  int countLetterInList(List<String> texts, String letter) {
    return texts
        .join('') // Combine all strings in the list into one
        .toLowerCase() // Convert to lowercase for case-insensitive comparison
        .split('') // Split the combined string into individual characters
        .where((char) => char == letter.toLowerCase()) // Filter the matching characters
        .length; // Count the occurrences
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: ActivityBackground(
        child: isLoaded ? Column(
          children: [
            Row(
              children: [
                ReturnButton(parentContext: context),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: printedText,
                  ),
                  AudioButton(
                    soundFiles: audioList,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 56.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1E9F6),
                                border: Border.all(
                                    color: isAnswerIncorrect
                                        ? const Color(0xFFA90C0C)
                                        : solvedActivity
                                            ? const Color(0xFF3AAB28)
                                            : const Color(0xFF03BFE7)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                controller: controller,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 16.0),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              )),
                          const SizedBox(
                            width: 36,
                          ),
                          CustomButton(
                            label: 'Enviar',
                            onPressed: () {
                              checkAnswer();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            solvedActivity
                                ? 'Resposta Correta!'
                                : isAnswerIncorrect
                                    ? 'Resposta Incorreta'
                                    : '',
                            style: TextStyle(
                              color: solvedActivity
                                  ? const Color(0xFF3AAB28)
                                  : const Color(0xFFA90C0C),
                              // You can customize the color or other styles as needed
                              fontFamily: 'Playpen-Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 156.0,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
        : const Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator(),)]
                ),
      ),
    );
  }
}

class ColorfulText extends StatelessWidget {
  final String text;
  final double fontSize;
  final String specialLetter;
  final bool solved;

  ColorfulText(this.text,
      {required this.fontSize,
      required this.specialLetter,
      required this.solved});

  List<TextSpan> _generateTextSpans(String text) {
    return text.split('').map((letter) {
      return TextSpan(
        text: letter,
        style: TextStyle(
          color: letter.toLowerCase() == specialLetter.toLowerCase()
              ? solved
                  ? Color(0xFF3AAB28)
                  : Colors.black
              : Colors.black, // Default color
          fontSize: fontSize,
          fontFamily: 'Playpen-Sans', // Fixed font family
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _generateTextSpans(text),
      ),
      textAlign: TextAlign.center,
    );
  }
}
