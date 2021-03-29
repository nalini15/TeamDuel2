import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/cricketMatchups.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/screens/cricket/matchups/myMatchUps.dart';
import 'package:winx/services/admob_services.dart';

class MatchUpJoined extends StatefulWidget {
  MatchUpJoined({Key key}) : super(key: key);

  @override
  _MatchUpJoinedState createState() => _MatchUpJoinedState();
}

class _MatchUpJoinedState extends State<MatchUpJoined> {
  Future<void> getUserMatchups() async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final res = await matchups.getUserMatchups();
    if (!res['status']) {
      showCupertinoPop(res, context);
    } else {
      // showCupertinoPop(res, context);
    }
  }

  final ams = AdmobService();

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
      // getMaxPayout(
      //     states.investType == InvestType.chips ? "chips" : "coins", true);
    },
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
  Future<void> addIni(dynamic data) async {
    try {
      await myInterstitial.load();
      Future.delayed(Duration(seconds: 2), () {
        myInterstitial.show();
        Navigator.push(
            context,
            SlideNavigation(
                widget: MyMatchUps(
              matchupId: data.matchupId.toString(),
            )));
      });
    } catch (e) {
      print(e.toString());
      myInterstitial.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserMatchups(),
      builder: (con, snap) => snap.connectionState == ConnectionState.waiting
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<MatchupsCrickets>(
              builder: (con, jointed, _) => jointed.joinedMatchups.isEmpty
                  ? Center(
                      child: Text("No Matchups Available"),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: List.generate(
                          jointed.joinedMatchups.length,
                          (index) {
                            var data = jointed.joinedMatchups[index];
                            return GestureDetector(
                              onTap: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                if (sharedPreferences
                                    .containsKey("joinedAdd")) {
                                  int counter =
                                      sharedPreferences.getInt("joinedAdd");
                                  if (counter == 4) {
                                    sharedPreferences.setInt(
                                        "joinedAdd", counter + 1);
                                    addIni(data);
                                  } else {
                                    sharedPreferences.setInt(
                                        "joinedAdd", counter + 1);
                                    Navigator.push(
                                        context,
                                        SlideNavigation(
                                            widget: MyMatchUps(
                                          matchupId: data.matchupId.toString(),
                                        )));
                                  }
                                } else {
                                  sharedPreferences.setInt("joinedAdd", 1);
                                  Navigator.push(
                                      context,
                                      SlideNavigation(
                                          widget: MyMatchUps(
                                        matchupId: data.matchupId.toString(),
                                      )));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                // padding: EdgeInsets.only(right: 28, left: 22, top: 19),
                                width: double.infinity,
                                height: 172,
                                decoration: BoxDecoration(
                                    color: AppColors.mainColorLight,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 28, left: 22, top: 19),
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "#${data.registerId}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${data.matchupDate}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                "${data.matchupStatus}",
                                                style: GoogleFonts.poppins(
// color: Colors.white,
                                                    color: AppColors.mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 25,
                                            width: 93,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(32)),
                                            child: Text(
                                              "${data.scoreStaus}",
                                              style: GoogleFonts.poppins(
                                                // color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Invested",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/images/coins.png",
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${data.returnPayout}",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Max payout",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/images/coins.png",
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${data.returnPayout}",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Matchups",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              "${data.matchupCount}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            )),
    );
  }
}
