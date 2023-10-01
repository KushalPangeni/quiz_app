import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz/constant/ad.dart';

class AppOpenAdManager {
  static bool isLoaded = false;
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  // Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: openAdUnit,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          log("Ad Loadede.................................");
          _appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          log(error.toString());
          // Handle the error.
        },
      ),
    );
  }

  void showAdIfAvailable() {
    log("Called=====================================================================");
    if (_appOpenAd == null) {
      log('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      log('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        log('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        log('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
