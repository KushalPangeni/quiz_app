// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/widgets/showdialogbox.dart';

class TestPage extends StatefulWidget {
  final List answersList, options;
  final String answer, title;
  final String pic1, pic2, pic3, pic4;
  const TestPage(
      {super.key,
      required this.answer,
      required this.title,
      required this.answersList,
      required this.options,
      required this.pic1,
      required this.pic2,
      required this.pic3,
      required this.pic4});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final controller = ConfettiController(
    duration: const Duration(seconds: 5),
  );

  bool changeAnswerColor = false;
  List answersList = <String>['', '', ''];
  List options = <String>['', '', ''];
  String answer = '';

  bool anyImageIsBigger = false;
  bool sizeSmall = true;
  String biggerImage = '';

  @override
  void initState() {
    super.initState();
    options = widget.options;
    answersList = widget.answersList;
    answer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.amber[50],
          appBar: AppBar(
            centerTitle: true,
            title: Text("Quiz"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(MediaQuery.sizeOf(context).height.toString()),
                Text(MediaQuery.sizeOf(context).width.toString()),
                //Images
                SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.4,
                    child: anyImageIsBigger
                        ? biggerImageContainer()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  photo1(widget.pic1),
                                  photo1(widget.pic2),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  photo1(widget.pic3),
                                  photo1(widget.pic4),
                                ],
                              )
                            ],
                          )
                    // GridView.count(
                    //     childAspectRatio: 1.2,
                    //     crossAxisSpacing: 5,
                    //     mainAxisSpacing: 5,
                    //     crossAxisCount: 2,
                    //     children: [
                    //       photo1(
                    //           'https://images.pexels.com/photos/14111067/pexels-photo-14111067.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    //       photo1(
                    //           'https://images.pexels.com/photos/2922277/pexels-photo-2922277.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    //       photo1(
                    //           'https://images.pexels.com/photos/976870/pexels-photo-976870.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    //       photo1(
                    //           'https://images.pexels.com/photos/792223/pexels-photo-792223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    //     ],
                    //   ),
                    ),
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                sizedbox20,
                //Answers
                // SizedBox(
                //   height: MediaQuery.sizeOf(context).width / 7,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     //     crossAxisCount: 5, childAspectRatio: 1.4, crossAxisSpacing: 4),
                //     itemCount: answer.length,
                //     itemBuilder: (context, index) {
                //       return cardForAnswers(index, alphabet: answersList[index] ?? '');
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.sizeOf(context).width / 7,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     //     crossAxisCount: 5, childAspectRatio: 1.4, crossAxisSpacing: 4),
                //     itemCount: answer.length,
                //     itemBuilder: (context, index) {
                //       return optionCard(index, alphabet: answersList[index] ?? '');
                //     },
                //   ),
                // ),

                //Answers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      answer.length, (index) => cardForAnswers(index, alphabet: answersList[index] ?? '')),
                ),
                sizedbox40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => optionCard(index, alphabet: options[index] ?? '')),
                ),
                sizedbox1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    // print(index + 5);
                    return optionCard(index + 5, alphabet: options[index + 5] ?? '');
                  }),
                ),
                //Options
                // Expanded(
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     itemCount: options.length,
                //     itemBuilder: (context, index) {
                //       return optionCard(index, alphabet: options[index] ?? '');
                //     },
                //   ),
                // ),
                // SizedBox(
                //   // color: Colors.black,
                //   height: 135,
                //   width: 500,
                //   child: GridView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 5, crossAxisSpacing: 4, mainAxisSpacing: 4, childAspectRatio: 1),
                //     itemCount: options.length,
                //     itemBuilder: (context, index) {
                //       return AspectRatio(aspectRatio: 1, child: optionCard(index, alphabet: options[index] ?? ''));
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: MediaQuery.sizeOf(context).width / 2,
          child: ConfettiWidget(
            numberOfParticles: 50,
            confettiController: controller,
            // shouldLoop: true,
            blastDirection: -pi / 2,
          ),
        )
      ],
    );
  }

  Widget cardForAnswers(int index, {String? alphabet}) {
    return InkWell(
      onTap: () {
        String? answers2 = alphabet;
        setState(
          () {
            for (int i = 0; i < options.length; i++) {
              if (options[i] == '') {
                options[i] = answers2;
                answersList[index] = '';
                break;
              }
            }
          },
        );
      },
      child: Container(
        height: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 60,
        width: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 60,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.white),
          boxShadow: [BoxShadow(offset: Offset(0, 2), color: Colors.grey, blurRadius: 10)],
        ),
        child: Center(
          child: Text(
            alphabet ?? '',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: changeAnswerColor ? Colors.red : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget optionCard(int index, {String? alphabet}) {
    return InkWell(
      onTap: () {
        String checkAnswer = '';
        String? answers2 = alphabet;
        setState(() {
          for (int i = 0; i < answersList.length; i++) {
            if (answersList[i] == '') {
              answersList[i] = answers2;
              options[index] = '';
              break;
            }
          }
        });
        for (var element in answersList) {
          checkAnswer += element;
        }
        // print("CheckAnswer $checkAnswer");
        // print("Answerlist $answersList");
        // print("Options $options");
        if (answer.length == checkAnswer.length && answer != checkAnswer) {
          changeAnswerColor = true;
        } else {
          changeAnswerColor = false;
        }
        if (answer == checkAnswer) {
          showWinDialog(context);
          // controller.play();
          // print("You Won");
        }
      },
      child: Container(
        height: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 64,
        width: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 64,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(offset: Offset(2, 1), color: Colors.grey, blurRadius: 0)],
        ),
        child: Center(
          child: Text(
            alphabet ?? '',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget biggerImageContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          biggerImage = '';
          anyImageIsBigger = false;
        });
      },
      child: anyImageIsBigger
          ? Container(
              height: MediaQuery.sizeOf(context).height / 2.5,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                  image: DecorationImage(image: NetworkImage(biggerImage), fit: BoxFit.cover),
                  border: Border.all(color: Colors.black, width: 4)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        biggerImage.split('?')[0],
                        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget photo1(String imgPath) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          // log('Tapped');
          setState(() {
            anyImageIsBigger = true;
            biggerImage = imgPath;
            // }
          });
        },
        child: Container(
          height: MediaQuery.sizeOf(context).width < 270 ? 120 : 150,
          width: MediaQuery.sizeOf(context).width < 324 ? MediaQuery.sizeOf(context).width / 2.3 : 150,
          decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
