import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_birthday/personal/letter.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> images = [
  "image/image1.heic",
  "image/image2.heic",
  "image/image3.heic",
  "image/image4.heic",
  "image/image5.heic",
  "image/image6.JPG",
  "image/image7.JPG",
  "image/image8.JPG",
  "image/image9.jpg",
  "image/image11.heic",
  "image/image12.HEIC",
  "image/image13.heic",
  "image/image14.heic",
  "image/image15.jpg",
  "image/image16.jpg",
  "image/image17.JPG",
  "image/image18.jpg",
  "image/image10.JPG"
];
int count = 2;

class Poem extends StatefulWidget {
  @override
  State<Poem> createState() => _PoemState();
}

class _PoemState extends State<Poem> with SingleTickerProviderStateMixin {
  ScrollController _sc = new ScrollController();
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late TabController _controller;
  bool show = false;
  late CardController controller;
  @override
  void initState() {
    super.initState();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 4));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 4));
    _controller = TabController(length: 2, vsync: this);
    show = false;
    _controller.addListener(() {
      if (_controller.index == 1) {
        print("chheck");
        controller = new CardController();

        setState(() {
          count = 2;
          show = false;
          print(show);
        });
      }
    });
    setState(() {
      _sc.addListener(() {
        print(count);
        if (_sc.position.pixels == _sc.position.maxScrollExtent &&
            count + 1 <= 18) {
          setState(() {
            print(count);
            count++;
          });
        }
        // else if(_sc.position.pixels == _sc.position.minScrollExtent)
      });
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color(0xffFDE5B5),
            appBar: AppBar(
              backgroundColor: const Color(0xffFFCBA5),
              bottom: TabBar(
                controller: _controller,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Message',
                  ),
                  Tab(
                    text: 'Memories',
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                'Happy Birthday Han',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 36, right: 16, bottom: 36),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: Colors.pink,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Letter.text,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.aBeeZee().fontFamily),
                                ).p(10)
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Lottie.asset("image/heart.json"),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ConfettiWidget(
                            confettiController: _controllerCenterLeft,
                            blastDirection: 0, // radial value - RIGHT
                            emissionFrequency: 0.6,
                            minimumSize: const Size(10,
                                10), // set the minimum potential size for the confetti (width, height)
                            maximumSize: const Size(50,
                                50), // set the maximum potential size for the confetti (width, height)
                            numberOfParticles: 1,
                            gravity: 0.1,
                          ),

                          // child: ImageList(
                          //   sc: _sc,
                          // ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ConfettiWidget(
                            confettiController: _controllerCenterRight,
                            blastDirection: pi, // radial value - LEFT
                            particleDrag: 0.05, // apply drag to the confetti
                            emissionFrequency: 0.05, // how often it should emit
                            numberOfParticles:
                                20, // number of particles to emit
                            gravity: 0.05, // gravity - or fall speed
                            shouldLoop: false,
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink
                            ], // manually specify the colors to be used
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: TinderSwapCard(
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: images.length,
                            swipeUp: true,
                            stackNum: 2,
                            swipeEdge: 2.0,
                            maxWidth: MediaQuery.of(context).size.width,
                            maxHeight: MediaQuery.of(context).size.width,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.width * 0.8,
                            cardBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                shadowColor: Colors.pinkAccent,
                                color: Colors.black,
                                child: Image.asset('${images[index]}').p(10),
                              );
                            },
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              if (align.x < 0) {
                                //print("Card is LEFT swiping");
                              } else if (align.x > 0) {
                                //print("Card is RIGHT swiping");
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              if (index > 16) {
                                setState(() {
                                  show = true;
                                });
                                _controllerCenterRight.play();
                                _controllerCenterLeft.play();
                              }
                              print(orientation.toString());
                              if (orientation == CardSwipeOrientation.LEFT) {
                                print("Card is LEFT swiping");
                                print(images.length);
                              } else if (orientation ==
                                  CardSwipeOrientation.RIGHT) {
                                print("Card is RIGHT swiping");
                                print(images.length);
                              }
                            },
                          ),
                        ).expand(),
                        if (!show)
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.topLeft,
                            child: Lottie.asset("image/conf.json"),
                          ),
                        if (show)
                          SafeArea(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              child: Lottie.asset("image/end.json"),
                            ),
                          ),
                      ],
                    )),
              ],
            )));
  }
}

//CatalogImage(ima
