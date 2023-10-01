// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constant/ad.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/constant/const_list.dart';
import 'package:quiz/provider/coin_provider.dart';
import 'package:quiz/test_page.dart';
import 'package:quiz/widgets/showdialogbox.dart';
import 'package:rive/rive.dart' as rive;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    log('Init');
    initBannerAd();
    Provider.of<CoinProvider>(context, listen: false).getCoins(context);
    Provider.of<CoinProvider>(context, listen: false).getLevelAtStart(context);
  }

  initBannerAd() {
    log('Init banner ads');
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
          log("$error");
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: false);
    return Scaffold(
      // appBar: AppBar(
      //   toolbarOpacity: 0,
      //   // shadowColor: Colors.transparent,
      //   // backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [SizedBox(width: 10)],
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         showCoinDialog(context);
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.amber[200],
      //           borderRadius: BorderRadius.circular(16),
      //           border: Border.all(width: 2, color: Colors.grey),
      //         ),
      //         child: Row(
      //           children: [
      //             SizedBox(width: 5),
      //             Icon(Icons.attach_money_rounded),
      //             Consumer<CoinProvider>(
      //               builder: (context, provider, child) => Text(
      //                 '${provider.coins ?? 0} ',
      //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //               ),
      //             ),
      //             Container(
      //               padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: Colors.amber,
      //                   boxShadow: [BoxShadow(offset: Offset(0.6, 0.6), color: Colors.grey)]),
      //               child: Text(
      //                 '+',
      //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //               ),
      //             ),
      //             SizedBox(
      //               width: 2,
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     )
      //   ],
      // ),
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
            rive.RiveAnimation.asset(
              'assets/distinguished-gentlemen.riv',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Consumer<CoinProvider>(
                builder: (context, provider, child) => ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  reverse: true,
                  itemCount: 31,
                  // itemCount: lists.length,
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
            ),
            //For pet
            Positioned(top: 30, left: 10, child: buyPet()),
            //For coin
            Positioned(top: 30, right: 10, child: coin()),
            Consumer<CoinProvider>(
              builder: (context, provider, child) => Positioned(
                bottom: 20,
                left: MediaQuery.sizeOf(context).width / 2 - 75,
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
                            hint: level[8],
                          ),
                          type: PageTransitionType.rightToLeft),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 55,
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
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : const SizedBox(),
    );
  }

  Widget buyPet() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Stack(
                children: [
                  AlertDialog(
                    backgroundColor: Colors.transparent,
                    title: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.amber[200], borderRadius: BorderRadius.circular(12)),
                      // height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Future Update',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "You can buy pets from next week. Trying to give update as soon as possible.",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ),
                          sizedbox20,
                          Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okay'))),
                        ],
                      ),
                    ),
                    elevation: 10,
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: Colors.amber[200],
          boxShadow: [BoxShadow(offset: Offset(0.6, 0.6), color: Colors.grey)],
          borderRadius: BorderRadius.circular(12), border: Border.all(width: 2, color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            'Buy Pets',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget coin() {
    return GestureDetector(
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
          // Navigator.push(
          //   context,
          //   PageTransition(
          //       child: TestPage(
          //         level: index,
          //         answer: level[2],
          //         title: level[3],
          //         answersList: level[0],
          //         options: level[1],
          //         pic1: level[4],
          //         pic2: level[5],
          //         pic3: level[6],
          //         pic4: level[7],
          //         hint: level[8],
          //       ),
          //       type: PageTransitionType.rightToLeft),
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
              color: Color(0xFFF680CF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(offset: Offset(0.5, 1), color: Colors.grey, blurRadius: 4)],
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
