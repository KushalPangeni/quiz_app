import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constant/ad.dart';
import 'package:quiz/provider/coin_provider.dart';
import 'package:quiz/splash%20screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoinProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: TestPage(
        //   answer: level1[2],
        //   title: level1[3],
        //   answersList: level1[0],
        //   options: level1[1],
        //   pic1: level1[4],
        //   pic2: level1[5],
        //   pic3: level1[6],
        //   pic4: level1[7],
        // ),
        home: const SplashScreen(),
      ),
    );
  }
}
