import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stroke_text/stroke_text.dart';

class GoldenTextSpecial extends StatelessWidget {
  final String text; // The letter or text this box represents
  final double textSize;
  final int borderColor;
  final double borderWidth;
  final FontWeight fontWeight; // Changed to FontWeight for better type consistency

  const GoldenTextSpecial({
    super.key,
    required this.text,
    double? textSize,
    int? borderColor,
    double? borderWidth,
    FontWeight? fontWeight,
  })  : textSize = textSize ?? 25.0,
        borderColor = borderColor ?? 0xFF012480,
        borderWidth = borderWidth ?? 3,
        fontWeight = fontWeight ?? FontWeight.w500;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFFFF3B8), Color(0xFFF7FB31), Color(0xFFFBB631)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0, 0.25, 1.0],
      ).createShader(bounds),
      child: StrokeText(
        text: text,
        textStyle: TextStyle(
          fontSize: textSize,
          fontFamily: 'Playpen-Sans',
          fontWeight: fontWeight, // Use fontWeight directly
          color: Colors.white,
        ),
        textAlign: TextAlign.justify,
        strokeColor: Color(borderColor),
        strokeWidth: borderWidth,
      ),
    );
  }
}
