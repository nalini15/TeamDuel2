import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/providers/user.dart';

class GetCoinsChips extends StatefulWidget {
  GetCoinsChips({Key key}) : super(key: key);

  @override
  _GetCoinsChipsState createState() => _GetCoinsChipsState();
}

class _GetCoinsChipsState extends State<GetCoinsChips> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> _shareImages(String referCode) async {
    try {
      final ByteData bytes1 =
          await rootBundle.load('assets/images/toppngBig.png');

      await Share.files(
          'esys image',
          {
            'Refer Code: $referCode': bytes1.buffer.asUint8List(),
          },
          'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  void copyReferCode(String code) {
    FlutterClipboard.copy(code).then((value) =>
        showSnackSuccess(context, "Copied to clipboard", _scaffoldkey));
  }

  final InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: 'ca-app-pub-3940256099942544/8691691433',
    request: AdRequest(),
    listener: AdListener(),
  );

  final AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
      // getMaxPayout(
      //     states.investType == InvestType.chips ? "chips" : "coins", true);
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) {
      ad.dispose();
      print("asdasdasdadasd");
      // getMaxPayout(
      //     states.investType == InvestType.chips ? "chips" : "coins", true);
    },
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
  Future<void> showCoinsAdd(
      BuildContext context, String from, String unitId) async {
    try {
      await myInterstitial.load();
      Future.delayed(Duration(seconds: 2), () {
        myInterstitial.show();
        Future.delayed(Duration(seconds: 5), () {
          getCoinsChips(from, unitId);
        });
      });
    } catch (e) {
      print(e.toString());
      myInterstitial.dispose();
    }
  }

  Future<void> getCoinsChips(String from, String unitId) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    var jsonData = {
      "ad_unit_id": "1212312312",
      "type": from,
    };
    final res = await matchups.addCoinsChips(jsonData);
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
    } else {
      showSnackSuccess(context, res['msg'], _scaffoldkey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Get More Coins",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                buildSizedBox(buildHeight(context), 0.10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // getCoinsChips("admob");
                          showCoinsAdd(context, "video",
                              "ca-app-pub-3940256099942544/8691691433");
                        },
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.mainColorLight,
                              borderRadius: BorderRadius.circular(10)),
                          child: watchFunc(
                              "+ 10",
                              [
                                "assets/images/toppngBig.png",
                                "assets/images/toppngBig.png"
                              ],
                              "Watch a Video AD "),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCoinsAdd(context, "offerwall",
                              "ca-app-pub-3940256099942544/8691691433");
                        },
                        child: Container(
                          height: 134,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.mainColorLight,
                              borderRadius: BorderRadius.circular(10)),
                          child: watchFunc(
                              "+ 50",
                              [
                                "assets/images/toppngBig.png",
                                "assets/images/offerWall.png"
                              ],
                              "OfferWall AD"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 134,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainColorLight,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/referFrd.png",
                        width: 102,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Refer your friends ",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "+ 50 ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/toppngBig.png",
                                  width: 12,
                                )
                              ],
                            ),
                            Text("(Both Get Get Free Coins)",
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: Color.fromRGBO(255, 255, 255, 0.7))),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("Referal Code",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.7))),
                                    Text("${user.userDetails[0].team_name}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Color.fromRGBO(
                                                252, 160, 49, 1))),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              copyReferCode(
                                                  "${user.userDetails[0].team_name}");
                                            },
                                            child: Image.asset(
                                                "assets/images/copy.png")),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              _shareImages(
                                                  "${user.userDetails[0].team_name}");
                                            },
                                            child: Image.asset(
                                                "assets/images/share.png")),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Do you Have Bonus Code ?",
                        style: GoogleFonts.poppins(
                            color: Color.fromRGBO(255, 255, 255, 0.7)),
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.mainColorLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "8S6M2VKYOR",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 12),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 23,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.buttonColor),
                              child: Text(
                                "Claim",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 38),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.mainColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/filterData.png",
                          width: 30,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Convert Coins",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget watchFunc(String title, List<String> image, String descp) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$title ",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                "${image[0]}",
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Image.asset(
            "${image[1]}",
            width: 30,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 134,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: descp == "OfferWall AD"
                    ? Color.fromRGBO(52, 157, 132, 1)
                    : Color.fromRGBO(136, 99, 211, 1)),
            child: Text(
              "$descp",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
