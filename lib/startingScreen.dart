import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:happy_birthday/utils/themes.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';
import 'Poem.dart';

class startingScreen extends StatefulWidget {
  @override
  _startingScreenState createState() => _startingScreenState();
}

class _startingScreenState extends State<startingScreen> {
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late Timer _timer;
  var allow = false;
  var daysLeft = 0;
  var hours = "00";
  var minutes = "00";
  var seconds = "00";
  int _start = 5;
  void startTimer() {
    var hr = 23 - DateTime.now().hour;
    var min = 59 - DateTime.now().minute;
    var sec = 59 - DateTime.now().second;
    var day = DateTime.now().day;
    var month = DateTime.now().month;
    var year = DateTime.now().year;
    if (day < 15 || month < 5 || year < 2023) {
      daysLeft = 14 - day;
    }

    if (day > 14 || month > 4 || year > 2022) {
      hr = 0;
      min = 0;
      sec = 0;
    }
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    hours = twoDigits(hr);
    minutes = twoDigits(min.remainder(60));
    seconds = twoDigits(sec.remainder(60));
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if ((hr < 1 &&
              min < 1 &&
              sec < 1 &&
              (day > 14 || month > 4 || year > 2022))) {
            _controllerCenterRight.play();
            _controllerCenterLeft.play();
            timer.cancel();

            allow = true;
          } else {
            allow = false;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    allow = false;
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 4));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: const Color(0xffFFCBA5),
      bottomNavigationBar: Container(
        height: 50,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: const Color(0xffFF9899),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //allow = true; // to remove
          if (allow) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Poem(),
                ));
          } else {
            VxToast.show(context, msg: "Thoda wait <3 :)");
          }
        },
        child: Icon(
          FlutterIcons.play_circle_faw5,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff13195b),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: MyThemes.gradientColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: 280,
                  //  color: Colors.pinkAccent,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("image/image1.heic"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              if (daysLeft != 0)
                "$daysLeft Days &".text.size(20).bold.black.make(),
              10.heightBox,
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                buildTimeCard(time: hours, header: 'HOURS'),
                SizedBox(
                  width: 8,
                ),
                buildTimeCard(time: minutes, header: 'MINUTES'),
                SizedBox(
                  width: 8,
                ),
                buildTimeCard(time: seconds, header: 'SECONDS'),
              ]),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16.0),
              //   child: Align(
              //       alignment: Alignment.topCenter,
              //       child: Text(
              //         "$_start",
              //         style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
              //       )),
              // ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConfettiWidget(
                      confettiController: _controllerCenterRight,
                      blastDirection: pi, // radial value - LEFT
                      particleDrag: 0.05, // apply drag to the confetti
                      emissionFrequency: 0.05, // how often it should emit
                      numberOfParticles: 20, // number of particles to emit
                      gravity: 0.05, // gravity - or fall speed
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink
                      ], // manually specify the colors to be used
                    ),
                  ),
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
                  ),

                  // Lottie.network(
                  //     "https://assets5.lottiefiles.com/packages/lf20_bfwzjr7h.json"),
                  Lottie.asset("image/birthdayPic.json"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );
}
