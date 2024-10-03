import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_widgets/return_button.dart';
import '../games/games.dart';
import 'story_button.dart';
import '../custom_widgets/selected_frame.dart';

// Model class for a Story
class Story {
  final Widget destination;
  final String buttonText;
  final List<String> svgPaths;

  Story({
    required this.destination,
    required this.buttonText,
    required this.svgPaths,
  });
}

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    const textSize = 28.0;

    // List of stories to be displayed
    final List<Story> stories = [
      Story(
        destination: Stories(), // Replace with your actual destination widget
        buttonText: "Super Heróis",
        svgPaths: [
          'assets/imgs/apartment.svg',
          'assets/imgs/electric_bolt.svg',
          'assets/imgs/domino_mask.svg',
        ],
      ),
      Story(
        destination: Stories(),
        buttonText: "Conto de Fadas",
        svgPaths: [
          'assets/imgs/castle.svg',
          'assets/imgs/crown.svg',
          'assets/imgs/star.svg',
        ],
      ),
      Story(
        destination: Stories(),
        buttonText: "Aventura Espacial",
        svgPaths: [
          'assets/imgs/planet.svg',
          'assets/imgs/rocket.svg',
          'assets/imgs/alien.svg',
        ],
      ),
      Story(
        destination: Stories(),
        buttonText: "Um dia na Floresta",
        svgPaths: [
          'assets/imgs/bird.svg',
          'assets/imgs/trail.svg',
          'assets/imgs/tree.svg',
        ],
      ),
      Story(
        destination: Stories(),
        buttonText: "Aniversário",
        svgPaths: [
          'assets/imgs/balloon.svg',
          'assets/imgs/cake.svg',
          'assets/imgs/gift.svg',
        ],
      ),
      Story(
        destination: Stories(),
        buttonText: "Piratas ao Mar",
        svgPaths: [
          'assets/imgs/ship.svg',
          'assets/imgs/map.svg',
          'assets/imgs/treasure.svg',
        ],
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/imgs/background.svg", // Update with your SVG path
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Row(children: [ReturnButton(parentContext: context)]),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
                ..._buildStoryButtons(stories), // Build the story buttons here
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build StoryButtons dynamically
  List<Widget> _buildStoryButtons(List<Story> stories) {
    List<Widget> rows = [];
    for (int i = 0; i < stories.length; i += 2) {
      List<Widget> rowButtons = [];
      for (int j = 0; j < 2 && (i + j) < stories.length; j++) {
        rowButtons.add(
          StoryButton(
            destination: stories[i + j].destination,
            buttonText: stories[i + j].buttonText,
            svgPaths: stories[i + j].svgPaths,
          ),
        );
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowButtons,
      ));
    }
    return rows;
  }
}
