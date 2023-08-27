// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/constant/const_list.dart';
import 'package:quiz/provider/coin_provider.dart';
import 'package:quiz/test_page.dart';
import 'package:quiz/widgets/showdialogbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    log('Init');
    Provider.of<CoinProvider>(context, listen: false).getCoins(context);
    Provider.of<CoinProvider>(context, listen: false).getLevelAtStart(context);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SizedBox(width: 10)],
        ),
        actions: [
          GestureDetector(
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
                  Consumer<CoinProvider>(
                    builder: (context, provider, child) => Text(
                      '${provider.coins ?? 0} ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        boxShadow: [BoxShadow(offset: Offset(0.6, 0.6), color: Colors.grey)]),
                    child: Text(
                      '+',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade200, Colors.amber.shade200],
          ),
          image: DecorationImage(image: AssetImage('assets/2.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Consumer<CoinProvider>(
              builder: (context, provider, child) => ListView.builder(
                controller: scrollController,
                reverse: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // if ((provider.level ?? 1) > 1) {
                  //   scrollController.animateTo(
                  //     (provider.level ?? 1) * 90,
                  //     duration: Duration(seconds: 2), 
                  //     curve: Curves.easeInOut,
                  //   );
                  // }

                  return selectLevel(context, index + 1);
                },
              ),
            ),
            Consumer<CoinProvider>(
              builder: (context, provider, child) => Positioned(
                bottom: 20,
                left: MediaQuery.sizeOf(context).width / 2 - 60,
                child: GestureDetector(
                  onTap: () {
                    // provider.getLevelAtStart(context);
                    var level = lists[provider.level ?? 1];
                    Navigator.push(
                      context,
                      PageTransition(
                          child: TestPage(
                            level: provider.level ?? 1,
                            answer: level[2],
                            title: level[3],
                            answersList: level[0],
                            options: level[1],
                            pic1: level[4],
                            pic2: level[5],
                            pic3: level[6],
                            pic4: level[7],
                          ),
                          type: PageTransitionType.rightToLeft),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.amber[200],
                        border: Border.all(width: 4, color: Colors.black.withOpacity(0.7))),
                    child: Center(
                        child: Text(
                      "Level ${provider.level ?? 1}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ),
            ),
            sizedbox10
          ],
        ),
      ),
    );
  }

  Widget selectLevel(
    BuildContext context,
    int index,
  ) {
    var level = lists[index];
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 30, 40, index == 1 ? 80 : 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
                child: TestPage(
                  level: index,
                  answer: level[2],
                  title: level[3],
                  answersList: level[0],
                  options: level[1],
                  pic1: level[4],
                  pic2: level[5],
                  pic3: level[6],
                  pic4: level[7],
                ),
                type: PageTransitionType.rightToLeft),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TestPage(
          //       answer: level[2],
          //       title: level[3],
          //       answersList: level[0],
          //       options: level[1],
          //       pic1: level[4],
          //       pic2: level[5],
          //       pic3: level[6],
          //       pic4: level[7],
          //     ),
          //   ),
          // );
        },
        child: Align(
          alignment: index % 4 == 0
              ? Alignment.centerLeft
              : index % 4 == 1
                  ? Alignment.center
                  : index % 4 == 2
                      ? Alignment.centerRight
                      : Alignment.center,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(0.5, 2), color: Colors.black, blurRadius: 4)],
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(width: 4, color: Colors.amber.shade200),
              // shape: BoxShape.circle,
              color: Color(0xFFF680CF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(offset: Offset(0.5, 1), color: Colors.grey, blurRadius: 4)],
                  // border: Border.all(width: 2),
                  // borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    Color(0xFFF800A4),
                    Color(0xFFDED5DB).withOpacity(0.4),
                  ]),
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                ),
                child: Center(
                  child: Text(
                    "$index",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
