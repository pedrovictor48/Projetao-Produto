import 'package:demo_app/ui/games/activities/complete_word.dart';
import 'package:demo_app/ui/games/activities/image_association.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../custom_widgets/return_button.dart';
import '../custom_widgets/selected_frame.dart';
import '../games/activities/build_letter.dart';
import '../games/activities/count_letters.dart';
import '../games/activities/drag_crossword.dart';
import '../games/activities/press_letter.dart';
import '../games/activities/select_word_by_audio.dart';
import '../games/activities/mark_the_word.dart';

class Minigames extends StatelessWidget {
  const Minigames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/background.svg", // Update with your SVG path
                fit: BoxFit.cover, // Same as the fit you used for PNG
              ),
            ),
            Column(
              children: [
                Row(children: [ReturnButton(parentContext: context)]),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: DragSyllables(subStoryId: 0, storyId: 0),
                            title: 'Arrastar Sílaba',
                            svgs: 'assets/imgs/drag.svg',
                            backgroundColor: Colors.lightBlueAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: CountLetters(subStoryId: 0, storyId: 0),
                            title: 'Contar Letras',
                            svgs: 'assets/imgs/hand_two.svg',
                            backgroundColor: Colors.redAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: BuildWord(subStoryId: 0, storyId: 0,),
                            title: 'Montar Palavra',
                            svgs: 'assets/imgs/press.svg',
                            backgroundColor: Colors.indigoAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: CompleteWord(subStoryId: 0, storyId: 0),
                            title: 'Completar Palavra',
                            svgs: 'assets/imgs/puzzle.svg',
                            backgroundColor: Colors.purpleAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: ImageAssociation(storyId: 0, subStoryId: 0),
                            title: 'Associar Imagem',
                            svgs: 'assets/imgs/image_icon.svg',
                            backgroundColor: Colors.lightGreenAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: SelectWordAudio(storyId: 0, subStoryId: 0),
                            title: 'Selecionar Palavras Pelo Áudio',
                            svgs: 'assets/imgs/letter_sound.svg',
                            backgroundColor: Colors.pinkAccent,
                            textSize: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressLetter(storyId: 0, subStoryId: 0),
                            title: 'Pressionar Letra',
                            svgs: 'assets/imgs/press_letter.svg',
                            backgroundColor: Colors.limeAccent,
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressLetter(storyId: 0, subStoryId: 0),
                            title: 'Pressionar Letra',
                            svgs: 'assets/imgs/press.svg',
                            backgroundColor: Colors.lightGreenAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressSyllable(storyId: 0, subStoryId: 0, syllable: 'Bo'),
                            title: 'Marcar Letras',
                            svgs: 'assets/imgs/',
                            backgroundColor: const Color.fromARGB(255, 80, 80, 80),
                            textSize: 20,
                          ),
                          SelectedFrame(
                            parentContext: context,
                            nextPage: PressLetter(storyId: 0, subStoryId: 0),
                            title: 'Ativ 10',
                            svgs: 'assets/imgs/press.svg',
                            backgroundColor: Colors.lightGreenAccent,
                            textSize: 20,
                          ),
                        ],
                      ),
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
