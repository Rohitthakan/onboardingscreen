import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onboarding_screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:async';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home:
      new Splash(),
    );
  }
}

class onboard extends StatefulWidget {
  const onboard({Key? key}) : super(key: key);

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  List<PageViewModel>getpages(){
    return[
      PageViewModel(
        image: Image.asset("assets/img_1.png"),
        titleWidget: Text(
          "Explore",style:
          TextStyle(
            color: Colors.pinkAccent,
            fontSize: 20,
          ),
        ),
        bodyWidget: Text("Discover events",
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 14,
        ),
        ),
        footer: Text("@Technozion'22", style: TextStyle(color: Colors.amber)),
      ),
      PageViewModel(
        image: Image.asset("assets/explore.png"),
        titleWidget: Text('Explore',style: TextStyle(color: Colors.pinkAccent, fontSize: 20)),
        bodyWidget: Text('Discover all events',style: TextStyle(color: Colors.blueAccent)),
        footer: Text("@Technozion'22",style: TextStyle(color: Colors.amber)),
      ),
      PageViewModel(
        image: Image.asset("assets/register.png"),
        titleWidget: Text('Explore',style: TextStyle(color: Colors.pinkAccent,fontSize: 20)),
        bodyWidget: Text('Discover all events',style: TextStyle(color: Colors.blueAccent)),
        footer: Text("@Technozion'22",style: TextStyle(color: Colors.amber)),
      ),
    ];
  }
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(34, 31, 30, 5),
          body: Container(
            padding:  EdgeInsets.only(top: 50),
            child: IntroductionScreen(
              done: Text(
                "",
                style: TextStyle(
                  color: Colors.pinkAccent,
                ),
              ),
              globalFooter: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: const Text(
                    'Let\'s go right away!',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
              ),
              onDone: (){},
              pages: getpages(),
              globalBackgroundColor: Color.fromRGBO(34, 31, 30, 5),
              showNextButton: false,
            ),
          ),
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MyApp()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new onboard(),
      ),
    );
  }
}


