import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/pet.dart';


class PetAdoptedMsg extends StatefulWidget {
  String name;
  PetAdoptedMsg(this.name, {Key? key}) : super(key: key);

  @override
  State<PetAdoptedMsg> createState() => _PetAdoptedMsg();
}

class _PetAdoptedMsg extends State<PetAdoptedMsg> {

  late ConfettiController _confettiController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    Future.delayed(Duration(microseconds: 500),(){
      _confettiController.play();
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confettiController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 200,
              width: ScreenUtil().screenWidth-120,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: isDarkMode? Color(0xff072020) :Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("You've now adopted\n${widget.name}",style: TextStyle(fontSize: 20,height: 1.9,color: isDarkMode? Colors.white: Colors.black),textAlign: TextAlign.center,),

                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Color(0xff1b797a)),
                        // fixedSize: MaterialStateProperty.all(Size(screenWidth-30, 50))
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Ok")
                  )
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              shouldLoop: false,
              blastDirection: 3.14 / 2,
              colors: const [
                Colors.green,
                Colors.yellow,
                Colors.pink,
                Colors.orange,
                Colors.blue
              ],
              // blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 3,
              emissionFrequency: 0.03,

              // 10 paticles will pop-up at a time
              numberOfParticles: 30,

              // particles will come down
              gravity: 0.1,
            ),
          ),

        ],
      ),
    );
  }
}
