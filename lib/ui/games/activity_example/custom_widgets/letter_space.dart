import 'package:flutter/material.dart';
import 'letter.dart';

class LetterSpace extends StatefulWidget {
  final String expectedLetter; // The correct letter this space should accept
  final Function(bool) correctLetterFound;

  const LetterSpace({super.key, required this.expectedLetter, required this.correctLetterFound});

  @override
  _LetterSpaceState createState() => _LetterSpaceState();
}

class _LetterSpaceState extends State<LetterSpace> {
  String? acceptedLetter; // To store the accepted letter
  bool isCorrectLetter = false; // To track if the correct letter was dropped

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) {
        return details.data == widget.expectedLetter; // Only accept the correct letter
      },
      onAcceptWithDetails: (details) {
        setState(() {
          isCorrectLetter = true; // Mark the letter as correct
          acceptedLetter = details.data; // Store the dropped letter
          widget.correctLetterFound(true);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return isCorrectLetter ? StaticLetterBox(text: acceptedLetter ?? '') : ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF071597), Color(0xFF194ACC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.95],
            ).createShader(bounds),
            child: Container(
              width: 67,
              height: 43,
              decoration: BoxDecoration(
                color: isCorrectLetter
                    ? Colors.green // Change to green when the correct letter is dropped
                    : const Color(0xFFFFFFFF), // Default color
                border: Border.all(
                  color: isCorrectLetter
                      ? Colors.green
                      : const Color(0xFF012480), // Change border color as well
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: acceptedLetter != null
                    ? Text(
                  acceptedLetter!, // Display the accepted letter
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
                    : null, // Empty container before the correct letter is accepted
              ),
            ),
          ),
        );
      },
    );
  }
}