import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iti/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myhight = MediaQuery.of(context).size.height;
    double mywight = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Container(
          height: myhight,
          width: mywight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Image.asset(
                'assets/images/logo2.gif',
                scale: 2,
              ),
              Column(
                children: [
                  Text(
                    'Todays ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Press Start 2P'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    ' Cryptocurrency  ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Press Start 2P'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    ' Prices By ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Press Start 2P'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'CRYPTOTO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Press Start 2P'),
                  ),
                ],
              ),
              SizedBox(
                height: 240,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mywight * 0.08),
                child: GestureDetector(
                  onTap: () {
                    Get.offAll(Home());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFf7971E),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mywight * 0.05,
                          vertical: myhight * 0.013),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Press Start 2P'),
                          ),
                          RotationTransition(
                            turns: AlwaysStoppedAnimation(310 / 360),
                            child: Icon(Icons.arrow_forward_rounded),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
