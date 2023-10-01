import 'package:flutter/material.dart';
import 'package:quiz/widgets/showdialogbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinProvider extends ChangeNotifier {
  int? coins;
  int? level;

  getCoins(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setInt('Coins', 0);// Set Coin to 0
    // pref.setInt('Level', 1); // Set Level to 1
    coins = pref.getInt('Coins');
    await Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (coins == null) {
        return showEntryCoinDialog(context);
      }
    });
    notifyListeners();
  }

  redeemCoins(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('Coins', value);
    coins = pref.getInt('Coins');
    notifyListeners();
  }

  addCoins(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    coins = pref.getInt('Coins');
    if (coins == null) {
      pref.setInt('Coins', value);
      coins = pref.getInt('Coins');
    } else {
      coins = coins! + value;
      pref.setInt('Coins', coins!);
    }
    coins = pref.getInt('Coins');
    notifyListeners();
  }

  decreaseCoins(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    coins = pref.getInt('Coins');
    coins = coins! - value;
    pref.setInt('Coins', coins!);
    coins = pref.getInt('Coins');
    notifyListeners();
  }

  getLevelAtStart(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    level = pref.getInt('Level');
    pref.setInt('Level', level ?? 1);
    level = pref.getInt('Level');
    notifyListeners();
  }

  saveLevel(int nextLevel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('Level', nextLevel);
    level = pref.getInt('Level');
    notifyListeners();
  }
}
