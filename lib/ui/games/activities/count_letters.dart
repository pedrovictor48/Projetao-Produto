import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../custom_widgets/return_button.dart';
import '../../games/games.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CountLetters(),
    );
  }
}

class CountLetters extends StatefulWidget {
  const CountLetters({super.key});

  @override
  _CountLettersState createState() => _CountLettersState();
}

class _CountLettersState extends State<CountLetters> {
  TextEditingController controller = TextEditingController();

  static const textSize = 25.0;
  static const int textColor = 0xFF03BFE7;
  static const int borderColor = 0xFF012480;

  bool isAnswerIncorrect = false;

  String get questionText => "Conte quantos '$letter' tem no seguinte texto";

  static const String textToCount =
      "Nina nadou na piscina enquanto o amigo cantava uma canção calma.";

  static const String letter = 'n';

  int letterCount = 13;

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Games()), // Replace with your target page
          );
        });
      } else {
        setState(() {
          isAnswerIncorrect = true; // Answer is incorrect, flash red
        });
        Future.delayed(Duration(milliseconds: 2500), () {
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/imgs/background.svg", // Update with your SVG path
              fit: BoxFit.cover, // Same as the fit you used for PNG
            ),
          ),
          Column(
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
                    Stack(
                      children: [
                        // This is the stroke text
                        Text(
                          questionText,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Playpen-Sans',
                            color: Color(borderColor),
                            // Stroke color
                            shadows: [
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(1.0, 1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(-1.0, -1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(1.0, -1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                              Shadow(
                                color: Color(borderColor), // Stroke color
                                offset: Offset(-1.0, 1.0), // Stroke offset
                                blurRadius: 0,
                              ),
                            ],
                          ),
                        ),
                        // This is the main text
                        Text(
                          questionText,
                          style: const TextStyle(
                              fontSize: textSize,
                              fontFamily: 'Playpen-Sans',
                              fontWeight: FontWeight.w500,
                              color: Color(textColor)),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 500, // Defina a largura desejada
                      child: ColorfulText(
                        textToCount,
                        fontSize: 24.0,
                        specialLetter: 'n',
                        solved: solvedActivity,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            constraints: const BoxConstraints(
                              maxHeight: 150,
                              maxWidth: 150,
                              minHeight: 10,
                              minWidth: 10,
                            ),
                            labelText: 'Número de Letras',
                            helperText: isAnswerIncorrect ? 'Resposta Incorreta' : solvedActivity ? 'Resposta Certa!' : null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isAnswerIncorrect ? Colors.red :
                                solvedActivity ? Colors.green :
                                Colors.grey, // Set to green if solved
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isAnswerIncorrect ? Colors.red :
                                solvedActivity ? Colors.green :
                                Colors.grey, // Flash red when focused
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),

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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
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
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
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
                  : Colors.black // Special letter color
              : Colors.black, // Default color
          fontSize: fontSize,
          fontFamily: 'Playpen-Sans', // Fixed font family
          fontWeight: FontWeight.w500,
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
