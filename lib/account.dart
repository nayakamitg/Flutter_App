import 'dart:ui';
import 'package:flutter/material.dart';

class account extends StatelessWidget {
  const account({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: Colors.transparent,
      body:
      Stack(children: [

        BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(color: Colors.black.withOpacity(0.3)),
      ),

       Container(
        color: const Color.fromARGB(0, 255, 193, 7),
       child: Center(child: Text("This is Account page",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
      ),
      
      ])
    );
  }
}
