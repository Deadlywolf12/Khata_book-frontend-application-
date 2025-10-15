import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
        
          Row(children: [
            Column(children: [
              Text("Good Morning,",style: TextStyle(),),
              Text("Ali!")
            ],)
          ],)
        
        ],),
      ),
    ));
  }
}