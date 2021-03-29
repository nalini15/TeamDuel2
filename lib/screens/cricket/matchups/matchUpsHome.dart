import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/getCoins.dart';
import 'package:winx/screens/howToPlay.dart';
import 'package:winx/screens/payableWinning.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/houndMatchups.dart';
import 'package:winx/widgets/homeDrawer.dart';

import 'package:winx/widgets/cricket/matchups/cricketMatchups.dart';
import 'package:winx/widgets/cricket/matchups/horseMatchups.dart';
import 'package:winx/widgets/cricket/matchups/matchupsJoined.dart';

class MatchUpHome extends StatefulWidget {
  MatchUpHome({Key key}) : super(key: key);

  @override
  _MatchUpHomeState createState() => _MatchUpHomeState();
}

void _modalBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                )),
            alignment: Alignment.center,
            child: Text(
              "Summary",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "I bet",
                            style: GoogleFonts.poppins(),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.backgroundColor,
                                ),
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  color: AppColors.backgroundColor,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppColors.mainColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                "assets/images/coins.png",
                                width: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("10",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.backgroundColor,
                                ),
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  color: AppColors.backgroundColor,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "+",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppColors.mainColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "To win",
                            style: GoogleFonts.poppins(),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/coins.png",
                                width: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("10",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: List.generate(10, (index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: 3, right: 15, bottom: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MatchUp(),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(6),
                              child: Text(
                                "VS",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            MatchUp(),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                // color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {},
              color: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Confirm and Submit",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
  ;
}

class _MatchUpHomeState extends State<MatchUpHome>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TabController tabController;
  final ams = AdmobService();
  @override
  void initState() {
    super.initState();
    getUserData();
    Admob.initialize(testDeviceIds: [ams.getAdMobId()]);
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    myInterstitial.dispose();

    super.dispose();
  }

  Coins coin;
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              dialogBackgroundColor: Colors.black,
            ),
            child: child,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    final states = Provider.of<CricketStates>(context, listen: false);
    states.chagneFilterCricket("");
    getCricketMatchups(f.format(selectedDate));
  }

  final f = new DateFormat('EEEE,MMM yy');

  Future<void> getCricketMatchups([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    matchups.cricketMatchupFetched = false;
    String dateIntial;
    if (date == null) {
      final f = new DateFormat('dd-MM-yyyy');
      dateIntial = f.format(DateTime.now());
    } else {
      dateIntial = date;
    }
    // date = "2020-10-20";
    if (states.selectionScreen == 2) {
      final res = await matchups.getMatchups(
          dateIntial, "cricket", states.selectionScreen, filter);
    } else if (states.selectionScreen == 1) {
      final res = await matchups.getMatchups(
          dateIntial, "horse", states.selectionScreen, filter);
    } else {
      final res = await matchups.getMatchups(
          dateIntial, "hound", states.selectionScreen, filter);
    }
  }

  final scratchKey = GlobalKey<ScratcherState>();

  Future<void> getMaxPayout(String payment, [bool showPopUp]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    final res = await matchups.getMaxPayout(
        states.invest,
        states.investType == InvestType.chips ? "chips" : "coins",
        states.horseMatchups.length +
            states.cricketMatchups.length +
            states.houndMatchups.length);
    if (!res['status']) {
      // showSnack(context, success['msg'], _scaffoldkey);
      showCupertinoPop(res, context);
    } else {
      // showSnackSuccess(context, success['msg'], _scaffoldkey);
      if (showPopUp != null) {
        showDialogSubmitDialog(context, submitMatchups, getMaxPayout);
      }
    }
  }

  Future<void> submitMatchups() async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    //
    // 4 - Hound
    // 1 - horse
    // 2 - cricket
    // 3 - mix
    int type = 0;

    //Signle check condition
    if (states.cricketMatchups.isNotEmpty) {
      type = 2;
    } else if (states.horseMatchups.isNotEmpty) {
      type = 1;
    } else if (states.houndMatchups.isNotEmpty) {
      type = 4;
    }

    // mixed check conditions

    /*
    a = cric
    b = horse
    c = hound

    a = b
    b = c
    c = a

    */

    print(type);
    if (states.cricketMatchups.isNotEmpty &&
        states.horseMatchups.isNotEmpty &&
        states.houndMatchups.isNotEmpty) {
      type = 3;
    }

    if (states.cricketMatchups.isNotEmpty && states.horseMatchups.isNotEmpty) {
      type = 3;
    }

    if (states.horseMatchups.isNotEmpty && states.houndMatchups.isNotEmpty) {
      type = 3;
    }

    if (states.cricketMatchups.isNotEmpty && states.houndMatchups.isNotEmpty) {
      type = 3;
    }

    states.cricketMatchups.forEach((element) {
      element.removeWhere((key, value) => key == "playerNumber");
    });
    states.horseMatchups.forEach((element) {
      element.removeWhere((key, value) => key == "horseNumber");
    });
    states.houndMatchups.forEach((element) {
      element.removeWhere((key, value) => key == "houndNumber");
    });
    var matchupsData =
        states.cricketMatchups + states.horseMatchups + states.houndMatchups;

    var data = {
      "user_id": "",
      "matchups": matchupsData,
      "bet_coins": states.invest.toString(),
      "matchup_type": type,
      "return_type": states.investType == InvestType.coins ? "coins" : "chips",
    } as Map<String, dynamic>;
    int count = data['matchups'].length;
    matchups.isSubmitLoading(true);
    final success = await matchups.postMatchups(data);
    matchups.isSubmitLoading(false);
    if (!success['status']) {
      // showSnack(context, success['msg'], _scaffoldkey);
      showCupertinoPop(success, context);
    } else {
      // showSnackSuccess(context, success['msg'], _scaffoldkey);
      showCupertinoPop(success, context);
      states.clearData();
      print("CLEAR");
    }
  }

  Future<void> submitScratchCard() async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    matchups.loadScratchCard(true);
    final res = await matchups.postScratchCard();
    matchups.loadScratchCard(false);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
      showSnackSuccess(context, "${res['msg']}", _scaffoldkey);
    });
  }

  Future<void> getUserData() async {
    final user = Provider.of<User>(context, listen: false);
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    await Admob.requestTrackingAuthorization();
    if (user.userDetails.isEmpty) {
      print('getUSER');
      // await getMatchupDateTime();
      await user.userData();
      final res = await matchups.getSratchCards();
      if (res['status']) {
        if (matchups.scratchCard.isNotEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    width: buildWidth(context) * 0.50,
                    height: buildHeight(context) * 0.50,
                    color: Colors.transparent,
                    child: Scratcher(
                      key: scratchKey,
                      brushSize: 55,
                      threshold: 60,
                      color: AppColors.mainColor,
                      onChange: (value) {},
                      onThreshold: () {
                        scratchKey.currentState
                            .reveal(duration: Duration(milliseconds: 500));
                        submitScratchCard();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: AppColors.mainColorLight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/teamduel.png",
                              width: 200,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "YOU WON",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              matchups.scratchCardLoading
                                  ? "Loading...."
                                  : "${matchups.scratchCard[0].expireStatus}",
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      }
    }
    if (user.getCoins.isEmpty) {
      print('in wallet');
      await user.getWallet();
    }
  }

  void showDatesBottomSheet(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final matchupDate = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
                children:
                    List.generate(matchupDate.matchupDates[0].data.length, (i) {
              var date = DateTime.fromMillisecondsSinceEpoch(
                      matchupDate.matchupDates[0].data[i] * 1000,
                      isUtc: true)
                  .toLocal();

              final dateToCheck = DateTime.fromMillisecondsSinceEpoch(
                      matchupDate.matchupDates[0].data[i] * 1000,
                      isUtc: true)
                  .toLocal();
              String todayTomm = "";
              final aDate = DateTime(
                  dateToCheck.year, dateToCheck.month, dateToCheck.day);
              if (aDate == today) {
                todayTomm = "Today";
              } else if (aDate == tomorrow) {
                todayTomm = "Tomorrow";
              }
              return Container(
                color: AppColors.mainColor,
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  title: todayTomm.isEmpty
                      ? Text(
                          "${formatter.format(date)}",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      : Text(
                          "$todayTomm",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                  onTap: () {
                    matchupDate.changeSelectedDate(
                        todayTomm.isEmpty ? formatter.format(date) : todayTomm,
                        states.selectionScreen);
                    matchupDate.selecteddateTime = date;
                    Navigator.of(context).pop();
                    getCricketMatchups(formatter.format(date));
                  },
                ),
              );
            })),
          );
        });
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
      // getMaxPayout(
      //     states.investType == InvestType.chips ? "chips" : "coins", true);
    },
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
  Future<void> addIni(CricketStates states) async {
    try {
      await myInterstitial.load();
      Future.delayed(Duration(seconds: 2), () {
        myInterstitial.show();
        getMaxPayout(
            states.investType == InvestType.chips ? "chips" : "coins", true);
      });
    } catch (e) {
      print(e.toString());
      myInterstitial.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    final matchups = Provider.of<MatchupsCrickets>(context);
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        key: _scaffoldkey,
        drawer: HomeDrawer(),
        appBar: states.isAppbar
            ? AppBar(
                flexibleSpace: appBarGradientContainer(),
                backgroundColor: Colors.blue,
                leading: Consumer<User>(
                  builder: (con, user, _) => user.getUser
                      ? Icon(
                          FontAwesomeIcons.stopwatch20,
                        )
                      : user.userDetails[0].img == 'null'
                          ? Icon(FontAwesomeIcons.stopwatch20)
                          : GestureDetector(
                              onTap: () =>
                                  _scaffoldkey.currentState.openDrawer(),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(
                                  FontAwesomeIcons.bars,
                                ),
                              ),
                            ),
                ),
                // bottom: TabBar(
                //   unselectedLabelColor: Colors.white54,
                //   labelColor: Colors.white,
                //   tabs: [
                //     Tab(
                //         child: Text(
                //       "Cricket",
                //       style: GoogleFonts.poppins(),
                //     )),
                //     Tab(
                //       child: Text(
                //         "Horse Racing",
                //         style: GoogleFonts.poppins(),
                //       ),
                //     ),
                //   ],
                //   indicatorColor: Color(0xFFC1282D),
                //   indicatorWeight: 3,
                //   controller: tabController,
                // ),
                actions: [
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  //   margin: EdgeInsets.symmetric(vertical: 12),
                  //   height: 29,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.white),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       Image.asset(
                  //         'assets/images/coins.png',
                  //         width: 15,
                  //         height: 15,
                  //       ),
                  //       SizedBox(
                  //         width: 4,
                  //       ),
                  //       Text(
                  //         Coins.total == null ? '0' : Coins.total,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.black, fontSize: 12),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // buildSizedBoxWidth(buildWidth(context), 0.06),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: EdgeInsets.symmetric(vertical: 12),
                    height: 29,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/toppngBig.png',
                          width: 15,
                          height: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                DownSlideNavigation(widget: PayableWinning()));
                          },
                          child: Text(
                            Coins.total == null ? '0' : Coins.total,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 9),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          FontAwesomeIcons.chevronDown,
                          color: Colors.white,
                          size: 8,
                        )
                      ],
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    width: 12,
                  ),
                  Consumer<CricketStates>(
                    builder: (con, state, _) => GestureDetector(
                        onTap: () {
                          // if (states.matchupSection ==
                          //     MatchupSections.joinedmatchups) {
                          //   state.changeMatchUpSection(
                          //       MatchupSections.lobbymatchup);
                          //   state.showHideAppBar(true);
                          // } else {
                          //   state.changeMatchUpSection(
                          //       MatchupSections.joinedmatchups);
                          //   state.showHideAppBar(false);
                          // }
                          Navigator.of(context)
                              .push(FadeNavigation(widget: GetCoinsChips()));
                        },
                        child: Icon(
                          FontAwesomeIcons.plusCircle,
                          size: 15,
                          color: Color.fromRGBO(16, 119, 194, 1),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Container(
                  //   // margin: EdgeInsets.only(right: 10),
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: <Widget>[
                  //       Image.asset(
                  //         "assets/images/Vector.png",
                  //         width: 20,
                  //       ),
                  //       Positioned(
                  //         right: -00,
                  //         top: 8,
                  //         child: Container(
                  //           width: 15,
                  //           height: 15,
                  //           alignment: Alignment.topRight,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Color.fromRGBO(173, 28, 10, 0.9),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                ],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // showDialogBox(context);
                      },
                      child: Row(
                        children: <Widget>[
                          // Text(
                          //   "Match Ups",
                          //   style: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.bold, fontSize: 13),
                          // ),
                          Image.asset(
                            "assets/images/teamduel.png",
                            width: 100,
                          )
                          // SizedBox(
                          //   width: 3,
                          // ),
                          // // Icon(
                          // //   Icons.arrow_drop_down,
                          // //   size: 18,
                          // //   color: Color(0xFFC1282D),
                          // // )
                        ],
                      ),
                    ),
                    // buildSizedBoxWidth(buildWidth(context), 0.10),
                    Spacer(),
                  ],
                ),
              )
            : AppBar(
                flexibleSpace: appBarGradientContainer(),
                backgroundColor: Colors.blue,
                leading: Consumer<User>(
                  builder: (con, user, _) => user.getUser
                      ? Icon(FontAwesomeIcons.stopwatch20)
                      : user.userDetails[0].img == 'null'
                          ? Icon(FontAwesomeIcons.stopwatch20)
                          : GestureDetector(
                              onTap: () =>
                                  _scaffoldkey.currentState.openDrawer(),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(FontAwesomeIcons.bars),
                              ),
                            ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Joint Match Ups",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     showDialogBox(context);
                    //   },
                    //   child: Row(
                    //     children: <Widget>[
                    //       Text(
                    //         "Match Ups",
                    //         style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.bold, fontSize: 15),
                    //       ),
                    //       SizedBox(
                    //         width: 3,
                    //       ),
                    //       Icon(
                    //         Icons.arrow_drop_down,
                    //         size: 18,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // buildSizedBoxWidth(buildWidth(context), 0.10),
                    // Text(
                    //   "MYTEAM ",
                    //   style: GoogleFonts.poppins(fontSize: 10),
                    // ),
                    // Text(
                    //   "DUEL",
                    //   style: GoogleFonts.poppins(
                    //       color: Color.fromRGBO(249, 223, 65, 1), fontSize: 10),
                    // ),
                    Spacer(),
                    Consumer<CricketStates>(
                      builder: (con, state, _) => GestureDetector(
                        onTap: () {
                          if (states.matchupSection ==
                              MatchupSections.joinedmatchups) {
                            state.changeMatchUpSection(
                                MatchupSections.lobbymatchup);
                            state.showHideAppBar(true);
                          } else {
                            state.changeMatchUpSection(
                                MatchupSections.joinedmatchups);
                            state.showHideAppBar(false);
                          }
                        },
                        child: Text(
                          states.matchupSection ==
                                  MatchupSections.joinedmatchups
                              ? "Lobby"
                              : "Jointed (0)",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        bottomSheet: states.matchupSection == MatchupSections.lobbymatchup
            ? Container(
                height: 75,
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AdmobBanner(
                  adUnitId: ams.getBannerAppId(),
                  adSize: AdmobBannerSize.FULL_BANNER,
                )
                //  Row(
                //   children: <Widget>[
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         GestureDetector(
                //           onTap: () {
                //             states.clearData();
                //           },
                //           child: Container(
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 20, vertical: 10),
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                     width: 1,
                //                     color: Color.fromRGBO(16, 119, 194, 1)),
                //                 borderRadius: BorderRadius.circular(13)),
                //             child: Row(
                //               children: <Widget>[
                //                 Text(
                //                   "Clear Selected",
                //                   style: GoogleFonts.poppins(
                //                       fontSize: 13, color: Colors.white),
                //                 ),
                //                 SizedBox(
                //                   width: 10,
                //                 ),
                //                 Text(
                //                   "${states.cricketMatchups.toList().length + states.horseMatchups.toList().length + states.houndMatchups.toList().length}",
                //                   style: GoogleFonts.poppins(
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     buildSizedBoxWidth(buildWidth(context), 0.02),
                //     Consumer<MatchupsCrickets>(
                //       builder: (con, matchup, _) => matchup.submitLoading
                //           ? Expanded(
                //               child: Container(
                //                   // width: 200,
                //                   alignment: Alignment.center,
                //                   child: CircularProgressIndicator()),
                //             )
                //           : Expanded(
                //               // width: 200,
                //               child: states.cricketMatchups.toList().length +
                //                           states.horseMatchups.toList().length +
                //                           states.houndMatchups
                //                               .toList()
                //                               .length ==
                //                       0
                //                   ? Container()
                //                   : RaisedButton(
                //                       color: Color.fromRGBO(16, 119, 194, 1),
                //                       shape: RoundedRectangleBorder(
                //                           borderRadius:
                //                               BorderRadius.circular(13)),
                //                       onPressed: () {
                //                         // _modalBottomSheetMenu(context);
                //                         // submitMatchups();
                //                         getMaxPayout(
                //                             states.investType ==
                //                                     InvestType.chips
                //                                 ? "chips"
                //                                 : "coins",
                //                             true);
                //                       },
                //                       child: Text("Submit",
                //                           style: GoogleFonts.poppins(
                //                             fontSize: 15,
                //                             color: Colors.white,
                //                           )),
                //                     ),
                //             ),
                //     )
                //   ],
                // ),
                )
            : Container(
                height: 0,
              ),
        floatingActionButton:
            states.matchupSection == MatchupSections.lobbymatchup &&
                    states.cricketMatchups.toList().length +
                            states.horseMatchups.toList().length +
                            states.houndMatchups.toList().length >=
                        4
                ? FloatingActionButton.extended(
                    backgroundColor: AppColors.mainColorLight,
                    elevation: 10,
                    onPressed: () {
                      addIni(states);
                    },
                    label: Row(
                      children: [
                        Text(
                          "Submit (${states.cricketMatchups.toList().length + states.horseMatchups.toList().length + states.houndMatchups.toList().length})",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            states.clearData();
                          },
                          child: Icon(
                            FontAwesomeIcons.trashAlt,
                            size: 20,
                          ),
                        )
                      ],
                    ))
                : null,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              states.isAppbar
                  ? Column(
                      children: <Widget>[
                        //Select Date
                        Container(
                          color: AppColors.mainColor,
                          width: double.infinity,
                          height: buildHeight(context) * 0.08,
                          alignment: Alignment.center,
                          child: matchups.matchupDateLoading
                              ? CircularProgressIndicator()
                              : Row(
                                  children: <Widget>[
                                    Container(
                                      color: AppColors.mainColor,
                                      margin: EdgeInsets.only(
                                          left: buildWidth(context) * 0.3),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (matchups.getMatchupDates[0].data
                                              .isEmpty) {
                                            showAlertDialogNoFilter(
                                                context, "No Dates Available");
                                          } else {
                                            showDatesBottomSheet(context);
                                          }
                                          // selectDate(context);
                                        },
                                        child:
                                            //Select date code
                                            Container(
                                          alignment: Alignment.center,

                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  32, 49, 70, 0.91),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      32, 49, 70, 0.91),
                                                  width: 1)),
                                          width: 128,
                                          height: 38,
                                          // padding: EdgeInsets.only(
                                          //     left: 10, top: 10, bottom: 10, right: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      32, 49, 70, 0.91),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .calendarAlt,
                                                    color: Colors.white,
                                                    size: 13,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    EdgeInsets.only(left: 2),
                                                child: Text(
                                                  "${matchups.selecteddateFor[states.selectionScreen - 1]}",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  FontAwesomeIcons.chevronDown,
                                                  color: Colors.white,
                                                  size: 13,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      FontAwesomeIcons.exclamationCircle,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            FadeNavigation(
                                                widget: HowToPlay()));
                                      },
                                      child: Text(
                                        "How to play",
                                        style: GoogleFonts.poppins(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                        ),

                        // buildSizedBox(buildHeight(context), 0.02),

                        // Screen Selector
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                states.getSelectedScreenLength(), (i) {
                              var data = states.selectedScreen[i];
                              bool isSelected = data['isSelected'] == true;
                              return GestureDetector(
                                onTap: () {
                                  states.switchMatchUpScreens(
                                      data['screen'], true);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          data['icon'],
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data['title'],
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.grey,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 83,
                                      height: 2,
                                      color: isSelected
                                          ? Colors.lightBlue
                                          : Colors.transparent,
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                        //Addmob
                        // Container(
                        //   width: double.infinity,
                        //   height: buildHeight(context) * 0.09,
                        //   color: Colors.black,
                        //   child: Center(
                        //     child: Text(
                        //       "Admob",
                        //       style: GoogleFonts.poppins(color: Colors.white),
                        //     ),
                        //   ),
                        //   // child: ,
                        // ),
                        buildSizedBox(buildHeight(context), 0.02),
                      ],
                    )
                  : Container(),
              states.isAppbar
                  ? states.selectionScreen == 2
                      ? CricketMatchups()
                      : states.selectionScreen == 1
                          ? HorseMatchups(states: states)
                          : HoundMatchups(states: states)
                  : MatchUpJoined()
            ],
          ),
        ));
  }

  // Container(
  //         child: states.isAppbar
  //             ? TabBarView(
  //                 controller: tabController,
  //                 children: <Widget>[
  //                   CricketMatchups(),
  //                   HorseMatchups(states: states),
  //                 ],
  //               )
  //             : MatchUpJoined()),

  Widget sections(
      String title, bool isActive, BuildContext context, MatchupSections data) {
    return Consumer<CricketStates>(
      builder: (context, state, _) => Expanded(
        child: GestureDetector(
          onTap: () {
            state.changeMatchUpSection(data);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: isActive ? Colors.white : const Color(0xffbe3e3e3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isActive ? AppColors.mainColor : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
