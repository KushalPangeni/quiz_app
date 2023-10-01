// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constant/ad.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/provider/coin_provider.dart';
import 'package:quiz/widgets/showdialogbox.dart';
import 'package:shimmer/shimmer.dart';

class TestPage extends StatefulWidget {
  final int level;
  final List answersList, options;
  final String answer, title;
  final String pic1, pic2, pic3, pic4;
  final String hint;
  const TestPage(
      {super.key,
      required this.level,
      required this.answer,
      required this.title,
      required this.answersList,
      required this.options,
      required this.pic1,
      required this.pic2,
      required this.pic3,
      required this.pic4,
      required this.hint});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final controller = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  bool changeAnswerColor = false;
  bool showWonDialogContainer = false;
  List answersList = <String>['', '', ''];
  List options = <String>['', '', ''];
  String answer = '';

  bool anyImageIsBigger = false;
  bool sizeSmall = true;
  String biggerImage = '';
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  @override
  void initState() {
    print('initstate');
    super.initState();
    initBannerAd();
    setState(
      () {
        options = widget.options;
        answersList = widget.answersList;
        answer = widget.answer;
      },
    );
  }

  @override
  void dispose() {
    print("Disposed");
    options = <String>['', '', ''];
    answersList = <String>['', '', ''];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showHintSelectionDialog(context, widget.hint);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      decoration: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius: BorderRadius.circular(16),
                        // boxShadow: [BoxShadow(offset: Offset(1, 1), color: Colors.grey)],
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: SizedBox(
                        width: 62,
                        child: Row(
                          children: [
                            Icon(Icons.electric_bolt_outlined),
                            Text(
                              "Hint",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Level ${widget.level}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Spacer(),
                  Consumer<CoinProvider>(
                    builder: (context, provider, child) => GestureDetector(
                      onTap: () {
                        showCoinDialog(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[200],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 2, color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(Icons.attach_money_rounded),
                            Text(
                              "${provider.coins ?? 0} ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                  boxShadow: [BoxShadow(offset: Offset(1, 1), color: Colors.grey)]),
                              child: Text(
                                '+',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10)
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Text(MediaQuery.sizeOf(context).height.toString()),
                  // Text(MediaQuery.sizeOf(context).width.toString()),
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
                            )),
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  sizedbox20,
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
                ],
              ),
            ),
            bottomNavigationBar: isAdLoaded
                ? SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  )
                : const SizedBox(),
          ),
          //Conffetti
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2 - 160,
            right: 0,
            child: ConfettiWidget(
              emissionFrequency: 0.02,
              numberOfParticles: 50,
              confettiController: controller,
              blastDirection: pi * 1.25,
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2 - 160,
            left: 0,
            child: ConfettiWidget(
              emissionFrequency: 0.02,
              numberOfParticles: 50,
              confettiController: controller,
              blastDirection: pi * 1.75,
            ),
          ),
          //Transparent
          if (showWonDialogContainer)
            Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.transparent,
                )),
          //DialogContainer
          if (showWonDialogContainer) wonDialogBox(context),
        ],
      ),
    );
  }

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  navigate() {
    Navigator.pop(context);
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
        height: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 40,
        width: MediaQuery.sizeOf(context).width < 340 ? MediaQuery.sizeOf(context).width / 7 : 40,
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
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return AlertDialog(
          //         title: Text("Restart"),
          //         actions: [
          //           IconButton(
          //               onPressed: () {
          //                 setState(
          //                   () {
          //                     options = widget.options;
          //                     answersList = widget.answersList;
          //                     answer = widget.answer;
          //                   },
          //                 );
          //                 // var level = lists[index];
          //                 // Navigator.pushReplacement(
          //                 //     context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeft));
          //                 // Navigator.push(
          //                 //   context,
          //                 //   PageTransition(
          //                 //       child: TestPage(
          //                 //         level: index,
          //                 //         answer: level[2],
          //                 //         title: level[3],
          //                 //         answersList: level[0],
          //                 //         options: level[1],
          //                 //         pic1: level[4],
          //                 //         pic2: level[5],
          //                 //         pic3: level[6],
          //                 //         pic4: level[7],
          //                 //         hint: level[8],
          //                 //       ),
          //                 //       type: PageTransitionType.rightToLeft),
          //                 // );
          //               },
          //               icon: Icon(Icons.restart_alt_outlined))
          //         ],
          //       );
          // });
          changeAnswerColor = true;
        } else {
          changeAnswerColor = false;
        }
        if (answer == checkAnswer) {
          setState(() {
            Provider.of<CoinProvider>(context, listen: false).addCoins(25);
            Provider.of<CoinProvider>(context, listen: false).saveLevel(widget.level + 1);
            showWonDialogContainer = true;
            controller.play();
            // showWinDialog(context);
            // print("You Won");
          });
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
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.amber[100],
                  border: Border.all(color: Colors.grey, width: 4)),
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: biggerImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.teal,
                          )),
                      errorWidget: (context, url, error) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.transparent),
                      child: Text(
                        biggerImage.split('?')[0],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                ],
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
            // color: Colors.amber,
            // gradient: LinearGradient(
            //     colors: [const Color.fromARGB(255, 226, 154, 178), const Color.fromARGB(255, 209, 173, 119)]),
            border: Border.all(color: Colors.grey, width: 5),
            borderRadius: BorderRadius.circular(2),
            // image: DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover),
          ),
          child: CachedNetworkImage(
            imageUrl: imgPath,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  color: Colors.teal,
                )),
            errorWidget: (context, url, error) => Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  color: Colors.teal,
                )),
          ),
        ),
      ),
    );
  }
}
