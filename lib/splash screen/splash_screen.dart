import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quiz/homepage.dart';
import 'package:quiz/splash%20screen/ad_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  double percent = 0;
  AppOpenAd? appOpenAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            // Color.fromARGB(255, 215, 206, 206),
            // Color.fromARGB(255, 163, 19, 67),
            Colors.orange.shade100,
            Colors.white
          ]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/icon.png'),
              const Spacer(),
              LinearPercentIndicator(
                lineHeight: 40,
                percent: percent / 100,
                progressColor: Colors.deepPurple.shade300,
                backgroundColor: Colors.deepPurple.shade100,
                animation: true,
                barRadius: const Radius.circular(50),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  changeProgress() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        percent += 10;
      });
      if (percent < 100) {
        changeProgress();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    changeProgress();

    //Load AppOpen Ad
    appOpenAdManager.loadAd();
    //Show AppOpen Ad After 8 Seconds
    Future.delayed(const Duration(seconds: 10)).then((value) {
      //Here we will wait for 8 seconds to load our ad
      //After 8 second it will go to HomePage
      appOpenAdManager.showAdIfAvailable();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }
}
