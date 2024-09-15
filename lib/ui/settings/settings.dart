import 'package:flutter/material.dart';
import '../custom_widgets/return_button.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(        
        body: Container(
          decoration: const BoxDecoration( 
            image: DecorationImage(
              image: AssetImage("assets/imgs/background.png"),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            children: [
              Row(children: 
                [ReturnButton(parentContext: context)]
              ),
              const Center(
                child: Text("Tela de Configurações"),
              )
            ],        
          )
        ),
      );
  }
}