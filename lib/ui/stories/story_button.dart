import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryButton extends StatelessWidget {
  final Widget destination; // Navigator destination
  final String buttonText; // Text to display on the button
  final List<String> svgPaths; // List of SVG asset paths

  const StoryButton({
    super.key,
    required this.destination,
    required this.buttonText,
    required this.svgPaths,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => destination), // Navigate to destination
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(35),
        ),
        height: 160,
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // Example margins
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              // Add padding around the text
              padding: const EdgeInsets.only(top: 16.0),
              // Adjust vertical padding as needed
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Playpen-Sans',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: svgPaths.map((path) {
                return Padding(
                  // Add padding around each SVG
                  padding: const EdgeInsets.only(bottom: 16.0),
                  // Adjust vertical padding as needed
                  child: SvgPicture.asset(
                    path,
                    width: 35,
                    height: 35,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
