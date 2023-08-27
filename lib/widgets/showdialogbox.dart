import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/constant/const.dart';
import 'package:quiz/provider/coin_provider.dart';

Future<dynamic> showHintSelectionDialog(BuildContext context) {
  return showDialog(
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
                      'Hint',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "You will lose \$50 for hint",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    sizedbox20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'))),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  var provider = Provider.of<CoinProvider>(context, listen: false);
                                  // provider.getCoins(context);
                                  int? coins = provider.coins;
                                  if (coins != null) {
                                    if (coins < 50) {
                                      notEnoughCoins(context);
                                    } else {
                                      provider.decreaseCoins(50);
                                      showHintDialog(context);
                                    }
                                  }
                                },
                                child: const Text('Okay'))),
                      ],
                    ),
                  ],
                ),
              ),
              elevation: 10,
            ),
          ],
        );
      });
}

Future<dynamic> showCoinDialog(BuildContext context) {
  return showDialog(
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
                      'Get more coins',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "This is where you can increase your coins",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text("Okay")),
                    )
                  ],
                ),
              ),
              elevation: 10,
            ),
          ],
        );
      });
}

Future<dynamic> showHintDialog(BuildContext context) {
  return showDialog(
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
                      'Hint',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Hint: Word start from B",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text("Okay")),
                    )
                  ],
                ),
              ),
              elevation: 10,
            ),
          ],
        );
      });
}

Future<dynamic> notEnoughCoins(BuildContext context) {
  return showDialog(
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
                      'Coins',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "You don't have enough coins.",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Get coins")),
                    )
                  ],
                ),
              ),
              elevation: 10,
            ),
          ],
        );
      });
}

Future<dynamic> showEntryCoinDialog(BuildContext context) {
  return showDialog(
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
                    'Entry Coins',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Redeem your coins for first day.",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () async {
                          navigatePop(context);
                          Provider.of<CoinProvider>(context, listen: false).redeemCoins(50);
                        },
                        child: const Text("Get \$50")),
                  )
                ],
              ),
            ),
            elevation: 10,
          ),
        ],
      );
    },
  );
}

navigatePop(BuildContext context) {
  Navigator.pop(context);
}

Widget wonDialogBox(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.amber[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Column(
              children: [
                Text(
                  "Congratulations",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "\$50 added to your bank",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        await Future.delayed(
                          const Duration(seconds: 1),
                        ).then((value) => navigatePop(context));
                      },
                      child: const Text("Next")),
                ))
          ],
        ),
      ),
    ),
  );
}
