import 'package:bppt_meeting/onboarding.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bppt_meeting/meeting.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen == true) {
      Navigator.of(context).pushReplacement(
          //new MaterialPageRoute(builder: (context) => OnboardingPage()));
          new MaterialPageRoute(builder: (context) => new Meeting()));
    } else {
      //await prefs.setBool('seen', false);
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnboardingPage()));
    }
  }

//https://stackoverflow.com/questions/50654195/flutter-one-time-intro-screen
//digunakan untuk membaca sudah pernah dibuka atau belum

  startSplashScreen() async {
    var duration = const Duration(milliseconds: 1500);
    return Timer(duration, () {
      return checkFirstSeen();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Image.asset(
          "assets/images/logo/logo2.png",
          width: 250.0,
          height: 53.0,
        ),
      ),
    );
  }
}
