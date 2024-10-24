import 'package:demo_app/ui/games/activities/custom_widgets/golden_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../custom_widgets/end_activity_popup.dart';
import '../../custom_widgets/return_button.dart';
import '../../games/story_games_screen.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/golden_text_special_case.dart';

class CountLetters extends StatefulWidget {
  int storyId;
  int subStoryId;
  CountLetters({super.key, required this.subStoryId, required this.storyId});

  @override
  _CountLettersState createState() => _CountLettersState();
}

class _CountLettersState extends State<CountLetters> {
  TextEditingController controller = TextEditingController();

  static const textSize = 25.0;
  static const int textColor = 0xFF03BFE7;
  static const int borderColor = 0xFF012480;

  bool isAnswerIncorrect = false;

  List<String> get questionText => [
        "Conte quantos ",
        letter,
        " ou ",
        letterLowerCase,
        " têm no seguinte texto."
      ];

  static const String textToCount =
      "Nina nadou na piscina enquanto o amigo cantava uma canção calma.";

  static const String letter = 'N';
  static String letterLowerCase = 'N'.toLowerCase();

  late int letterCount;

  bool solvedActivity = false;

  @override
  void initState() {
    super.initState();
    letterCount = countLetter(textToCount, letter);
  }

  void checkAnswer() {
    String userAnswer = controller.text;

    if (userAnswer.isEmpty) {
      print('Please enter an answer');
    } else {
      int? answerAsInt = int.tryParse(userAnswer);

      if (answerAsInt == null) {
        print('Please enter a valid number');
      } else if (answerAsInt == letterCount) {
        setState(() {
          solvedActivity = true;
          isAnswerIncorrect = false;
        });
        Future.delayed(Duration(seconds: 3), () {
          // Replace with your navigation logic
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndActivityPopup(
                currentScreen: CountLetters(subStoryId: widget.subStoryId, storyId: widget.storyId),
                story: widget.subStoryId != 0 ? true : false,
                storyId: widget.storyId,
                subStoryId: widget.subStoryId,
                ctx: context,
              ); // Call your custom popup
            },
            barrierDismissible: false,
          );
        });
      } else {
        setState(() {
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

  int countLetter(String text, String letter) {
    return text
        .toLowerCase()
        .split('')
        .where((char) => char == letter.toLowerCase())
        .length;
  }

  @override
  Widget build(BuildContext context) {
    TextSpan printedText = TextSpan(
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
        TextSpan(
          text: questionText[3],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'Playpen-Sans', // Fixed font family
            fontWeight: FontWeight.bold,
          ), // Style for normal text
        ),
        WidgetSpan(
          child: GoldenTextSpecial(
            text: questionText[4],
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

    return Scaffold(
      body: ActivityBackground(
          child: Column(
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
                SizedBox(
                  width: 500,
                  child: ColorfulText(
                    textToCount,
                    fontSize: 24.0,
                    specialLetter: 'n',
                    solved: solvedActivity,
                  ),
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
                        Container(
                          height: 56.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    0.5,
                                    0.9,
                                  ],
                                  colors: [
                                    Color(0xff03BFE7),
                                    Color(0xff01419F)
                                  ]),
                              borderRadius: BorderRadius.circular(30)),
                          child: OutlinedButton(
                            onPressed: () {
                              checkAnswer();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.transparent),
                              shadowColor: WidgetStateProperty.all<Color>(
                                  Colors.transparent),
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                            ),
                            child: const Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 360 * 0.01),
                                        child: Text(
                                          'Enviar',
                                          style: TextStyle(
                                            fontFamily: 'Playpen-Sans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
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
      )),
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
