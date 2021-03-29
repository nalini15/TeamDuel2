import 'dart:io';

class AdmobService {
  String getAdMobId() {
    if (Platform.isIOS) {
      return "ca-app-pub-7093216290853733~8059126642";
    } else {
      return "ca-app-pub-7093216290853733~8370117838";
    }
  }

  String getBannerAppId() {
    if (Platform.isIOS) {
      return "ca-app-pub-7093216290853733/6746044971";
    } else {
      return "ca-app-pub-3940256099942544/6300978111";
    }
  }

  String getNativeAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1044960115';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1044960115';
    }
  }

  String getIntersttials() {
    if (Platform.isIOS) {
      return "ca-app-pub-7093216290853733/6746044971";
    } else {
      return "ca-app-pub-7093216290853733/6521316716";
    }
  }
}
