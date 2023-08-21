import 'package:flutter/material.dart';
import 'package:quiz/test_page.dart';

import 'constant/const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TestPage(
        answer: level1[2],
        title: level1[3],
        answersList: level1[0],
        options: level1[1],
        pic1: level1[4],
        pic2: level1[5],
        pic3: level1[6],
        pic4: level1[7],
      ),
      // home: const ImageTest(),
    );
  }
}