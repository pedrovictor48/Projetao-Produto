import 'package:flutter/material.dart';
import 'custom_widgets/activity_background.dart';
import 'custom_widgets/letter.dart';
import '../../custom_widgets/return_button.dart';

class UpperLower extends StatefulWidget {
  String storyId;
  int subStoryId;  

  UpperLower(
      {super.key, required this.storyId, required this.subStoryId});

  @override
  _UpperLowerState createState() => _UpperLowerState();
}

class _UpperLowerState extends State<UpperLower> {

  double width = 150.0;
  List<String> maiusculas = ["FURACÃO", "BATATA", "PEQUENO", "ROUPA"];
  List<String> minusculas = ["furacão", "batata", "pequeno", "roupa"];

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: LetterBox(text: maiusculas[0], borderRadius: 1.0, width: width)
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: StaticLetterBox(text: minusculas[0],
                                       borderRadius: 1.0,
                                       width: width,
                                       colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                       boxShadowColor: const Color.fromARGB(255, 49, 227, 251),                                       
                                      )
     
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: LetterBox(text: maiusculas[1], borderRadius: 1.0, width: width)
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: StaticLetterBox(text: minusculas[1],
                                       borderRadius: 1.0,
                                       width: width,
                                       colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                       boxShadowColor: const Color.fromARGB(255, 49, 227, 251),                                       
                                      )
     
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: LetterBox(text: maiusculas[2], borderRadius: 1.0, width: width)
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: StaticLetterBox(text: minusculas[2],
                                       borderRadius: 1.0,
                                       width: width,
                                       colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                       boxShadowColor: const Color.fromARGB(255, 49, 227, 251),                                       
                                      )
     
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: LetterBox(text: maiusculas[3], borderRadius: 1.0, width: width)
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: StaticLetterBox(text: minusculas[3],
                                       borderRadius: 1.0,
                                       width: width,
                                       colors: const [Color.fromARGB(255, 15, 15, 15), Color.fromARGB(255, 49, 86, 251), Color.fromARGB(255, 49, 153, 251)],
                                       boxShadowColor: const Color.fromARGB(255, 49, 227, 251),                                       
                                      )
     
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const Spacer(),
              ]
            )
          ]
        )
      )
    );
  }
}