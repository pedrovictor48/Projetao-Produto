import 'package:demo_app/ui/games/activities/custom_widgets/audio_button.dart';
import 'package:demo_app/ui/games/activities/custom_widgets/pressable_letters.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

class SoundLettersAssociation extends StatefulWidget {
  int storyId;
  int subStoryId;

  SoundLettersAssociation(
      {super.key, required this.storyId, required this.subStoryId});

  @override
  _SoundLettersAssociationState createState() =>
      _SoundLettersAssociationState();
}

class _SoundLettersAssociationState extends State<SoundLettersAssociation> {
  bool dialogShown = false; // Add a flag to check if the dialog has been shown

  Random random = Random();

  late int letterAnswer;

  List<String> allLetters = [
    'A.wav',
    'B.wav',
    'C.wav',
    'D.wav',
    'E.wav',
    'F.wav',
    'G.wav',
    'H.wav',
    'I.wav',
    'J.wav',
    'K.wav',
    'L.wav',
    'M.wav',
    'N.wav',
    'O.wav',
    'P.wav',
    'Q.wav',
    'R.wav',
    'S.wav',
    'T.wav',
    'U.wav',
    'V.wav',
    'W.wav',
    'X.wav',
    'Y.wav',
    'Z.wav'
  ];
  List<String> activityLetters = [];
  List<String> audioChosenLetters = [];
  List<String> chosenLetters = [];

  // Store the current color of each button
  Map<String, List<Color>> buttonColors = {};

  List<Color> defaultColor = [const Color(0xFFFBB631), const Color(0xFFF7FB31)];
  List<Color> correctColor = [const Color(0xFF03A603), const Color(0xFF45FF2D)];
  List<Color> incorrectColor = [
    const Color(0xFF991C1C),
    const Color(0xFFFF2F2F)
  ];

  List<String> get questionText =>
      ["Ouça o áudio e escolha as letras que você ouviu."];

  @override
  void initState() {
    super.initState();
    _initializeLetters();
  }

  void _initializeLetters() {
    // Choose 6 unique random letters for activityLetters
    activityLetters = (allLetters..shuffle(random)).take(6).toList();

    // From those, pick 3 unique random letters for chosenLetters
    chosenLetters = (activityLetters..shuffle(random)).take(3).toList();

    // Randomly convert some letters to lowercase
    activityLetters = activityLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    // Randomly convert some letters to lowercase
    audioChosenLetters = chosenLetters.map((letter) {
      return random.nextBool() ? letter.toLowerCase() : letter;
    }).toList();

    chosenLetters = audioChosenLetters.map((str) => str.replaceAll('.wav', '')).toList();

    // Shuffle activityLetters to randomize their order
    activityLetters.shuffle(random);

    activityLetters = activityLetters.map((str) => str.replaceAll('.wav', '')).toList();

    buttonColors = {
      for (var letter in activityLetters) letter: defaultColor,
    };

    letterAnswer = chosenLetters.length;
  }

  void _handleButtonPress(String letter) {
    setState(() {
      if (chosenLetters.contains(letter.toUpperCase()) ||
          chosenLetters.contains(letter.toLowerCase())) {
        // Correct letter: green gradient
        buttonColors[letter] = [correctColor[0], correctColor[1]];
        letterAnswer -= 1;
      } else {
        // Incorrect letter: red gradient
        buttonColors[letter] = [incorrectColor[0], incorrectColor[1]];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (letterAnswer <= 0 && !dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          // To avoid multiple calls to showDialog, we set a flag
          setState(() {
            dialogShown = true; // Ensure the dialog is only shown once
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                  currentScreen: SoundLettersAssociation(
                      subStoryId: widget.subStoryId, storyId: widget.storyId),
                  story: widget.subStoryId != 0 ? true : false,
                  storyId: widget.storyId,
                  subStoryId: widget.subStoryId,
                  ctx: context);
            },
            barrierDismissible: false,
          );
        });
      });
    }

    TextSpan printedText = TextSpan(children: [
      WidgetSpan(
        child: GoldenTextSpecial(
          text: questionText[0],
          textSize: 25,
          // Adjust as needed
          borderColor: 0xFF012480,
          // Adjust as needed
          borderWidth: 3,
          fontWeight: FontWeight.w500,
        ),
      ),
    ]);

    return Scaffold(
      body: ActivityBackground(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    ReturnButton(parentContext: context),
                  ],
                ),
                RichText(
                  text: printedText,
                ),
                AudioButton(soundFiles: ['letter_sounds/b.wav', 'letter_sounds/b.wav']), // passa audioChosenLetters aqui.
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: activityLetters.take(3).map((letter) {
                          return CustomButton(
                            label: letter,
                            onPressed: () => _handleButtonPress(letter),
                            colorEnd: buttonColors[letter]![0],
                            colorStart: buttonColors[letter]![1],
                            letterColor: Colors.black,
                            hasStroke: true,
                            strokeColor: Colors.black,
                          );
                        }).toList(),
                      ),
                      const Spacer(flex: 2), // Space between rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: activityLetters.skip(3).take(3).map((letter) {
                          return CustomButton(
                            label: letter,
                            onPressed: () => _handleButtonPress(letter),
                            colorEnd: buttonColors[letter]![0],
                            colorStart: buttonColors[letter]![1],
                            letterColor: Colors.black,
                            hasStroke: true,
                            strokeColor: Colors.black,
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}