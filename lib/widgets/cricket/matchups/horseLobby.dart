import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/adBanner.dart';
import 'package:winx/widgets/cricket/matchups/nativeAds.dart';

class HorseMatchUpLobby extends StatefulWidget {
  HorseMatchUpLobby({Key key}) : super(key: key);

  @override
  _HorseMatchUpLobbyState createState() => _HorseMatchUpLobbyState();
}

class _HorseMatchUpLobbyState extends State<HorseMatchUpLobby> {
  DateTime selectedDate = DateTime.now();
  final ams = AdmobService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHorseMatchups();
  }

  final f = new DateFormat('dd-MM-yyyy');

  Future<void> getMatchupDateTime() async {
    final matchup = Provider.of<MatchupsCrickets>(context, listen: false);
    final res = await matchup.getMatchupDateTime();
    if (!res['status']) {
      showCupertinoPop(res, context);
    }
  }

  Future<void> getHorseMatchups([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    matchups.cricketMatchupFetched = false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    String dateIntial;

    if (matchups.selecteddateTime == null) {
      if (matchups.matchupDates.isEmpty) {
        await getMatchupDateTime();
      }
      final f = new DateFormat('dd-MM-yyyy');
      if (matchups.matchupDates.isEmpty) {
        dateIntial = f.format(DateTime.now());
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                matchups.matchupDates[0].data[0] * 1000,
                isUtc: true)
            .toLocal();
        dateIntial = f.format(date);
      } else {
        dateIntial = f.format(DateTime.now());
      }
      final dateToCheck = DateTime.fromMillisecondsSinceEpoch(
              matchups.matchupDates[0].data[0] * 1000,
              isUtc: true)
          .toLocal();
      String todayTomm = "";
      final aDate =
          DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
      if (aDate == today) {
        todayTomm = "Today";
      } else if (aDate == tomorrow) {
        todayTomm = "Tomorrow";
      }
      final res = await matchups.getMatchups(
          dateIntial, "horse", states.selectionScreen, filter);
      matchups.changeSelectedDate(
          todayTomm.isEmpty ? f.format(dateToCheck) : todayTomm,
          states.selectionScreen);
    } else {
      dateIntial = f.format(matchups.selecteddateTime);
      String todayTomm = "";
      final aDate = DateTime(matchups.selecteddateTime.year,
          matchups.selecteddateTime.month, matchups.selecteddateTime.day);
      if (aDate == today) {
        todayTomm = "Today";
      } else if (aDate == tomorrow) {
        todayTomm = "Tomorrow";
      }
      final res = await matchups.getMatchups(
          dateIntial, "horse", states.selectionScreen, filter);
      matchups.changeSelectedDate(
          todayTomm.isEmpty ? f.format(matchups.selecteddateTime) : todayTomm,
          states.selectionScreen);
    }
    // if (matchups.horseMatchups.isEmpty) {

    // }
  }

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    return Consumer<MatchupsCrickets>(
      builder: (con, state, _) => FutureBuilder(
        future: null,
        builder: (con, snap) => snap.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // SizedBox(
                          //   width: 19,
                          // ),
                          Text(
                            "Select  ( min 4 - Max 15) match-up to play",
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.white),
                          ),
                          Consumer<MatchupsCrickets>(
                            builder: (con, filter, _) {
                              if (filter.getHorseMatchesLocation.isNotEmpty) {
                                if (states.selectedFilterHorse.isEmpty) {
                                  states.selectedFilterHorse = "Filter";
                                } else {
                                  states.selectedFilterHorse =
                                      states.selectedFilterHorse;
                                }
                              }

                              return Expanded(
                                child: Container(
                                  height: 38,
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Dialog errorDialog = Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12.0)), //this right here
                                        child: Container(
                                            color: AppColors.mainColorLight,
                                            height: 300.0,
                                            width: 300.0,
                                            child: ListView.builder(
                                                itemCount: filter
                                                    .horseMatchesLocation
                                                    .length,
                                                itemBuilder: (con, i) {
                                                  return Card(
                                                    color: AppColors.mainColor,
                                                    elevation: 7,
                                                    margin: EdgeInsets.only(
                                                        top: 10,
                                                        right: 10,
                                                        left: 10),
                                                    child: ListTile(
                                                      onTap: () {
                                                        states.chagneFilterHorse(
                                                            "${filter.horseMatchesLocation[i].locations}");
                                                        getHorseMatchups(
                                                            f.format(
                                                                selectedDate),
                                                            filter
                                                                .getHorseMatchesLocation[
                                                                    i]
                                                                .locations
                                                                .toString());
                                                        Navigator.of(context)
                                                            .pop();
                                                        // print(states
                                                        //     .selectedFilterHorse);
                                                      },
                                                      title: Text(
                                                        "${filter.horseMatchesLocation[i].locations}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      );
                                      states.selectedFilterHorse.isNotEmpty
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  errorDialog)
                                          : showAlertDialogNoFilter(context);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/filter.png",
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${states.selectedFilterHorse.isEmpty ? "All" : states.selectedFilterHorse}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          GestureDetector(
                            onTap: () {
                              states.toogleRefresh(true);
                              getHorseMatchups();
                              states.toogleRefresh(false);
                            },
                            child: states.isRefresh
                                ? Text("asadssad")
                                : Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFCA031),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text("Refresh")),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    state.horseMatchups.isEmpty
                        ? noMatchups(context)
                        : Column(
                            children: List.generate(state.horseMatchups.length,
                                (index) {
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(state.horseMatchups[index]
                                          .utcMatchStartTimeStamp) *
                                      1000);
                              print("---------------------");
                              print(date);
                              print("---------------------");
                              var remaining;
                              var time = 'min';
                              remaining =
                                  date.difference(DateTime.now()).inMinutes;
                              if (remaining.toString().contains("-")) {
                                remaining = '0';
                                time = 'ended';
                              } else {
                                if (remaining > 60) {
                                  remaining =
                                      date.difference(DateTime.now()).inHours;
                                  time = 'hr';
                                }
                              }
                              return Column(
                                children: <Widget>[
                                  state.horseMatchups.length <= 3
                                      ? NativeAds(
                                          nativekey: ams.getNativeAdId(),
                                        )
                                      : Container(),
                                  Container(
                                    color: Color.fromRGBO(32, 49, 70, 0.91),
                                    margin: EdgeInsets.only(bottom: 1),
                                    child: ExpansionTile(
                                      title: Row(
                                        children: <Widget>[
                                          Text(
                                            "${state.horseMatchups[index].raceName}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                          // buildSizedBoxWidth(buildWidth(context), 0.05),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "$remaining $time",
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          color: AppColors.mainColor,
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, bottom: 20),
                                          child: Column(
                                            children: List.generate(
                                                state.horseMatchups[index]
                                                    .matchups.length, (i) {
                                              var matchup1 = state
                                                  .horseMatchups[index]
                                                  .matchups[i]
                                                  .matchupOne;
                                              var matchup2 = state
                                                  .horseMatchups[index]
                                                  .matchups[i]
                                                  .matchupTwo;

                                              var data = states.horseMatchups
                                                  .where((element) =>
                                                      element['matchup_id'] ==
                                                      state.horseMatchups[index]
                                                          .matchups[i].matchupId
                                                          .toString());
                                              bool isLeft = false;
                                              if (!data.isEmpty) {
                                                if (data.toList()[0]
                                                        ['horseNumber'] ==
                                                    matchup1.horseNo
                                                        .toString()) {
                                                  isLeft = true;
                                                } else {
                                                  isLeft = false;
                                                }
                                              }
                                              return Column(
                                                children: [
                                                  i != 0 && i % 3 == 0
                                                      ? Container(
                                                          height: 75,
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              double.infinity,
                                                          color: Colors.black,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          child: AdBanner(
                                                            stringKey: ams
                                                                .getBannerAppId(),
                                                            size:
                                                                AdmobBannerSize
                                                                    .BANNER,
                                                          ))
                                                      : Container(),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              print(state
                                                                  .horseMatchups[
                                                                      index]
                                                                  .matchups[i]
                                                                  .matchupId);
                                                              print("left");
                                                              states.addhorseMatchUps(
                                                                  state
                                                                      .horseMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchupId
                                                                      .toString(),
                                                                  state
                                                                      .horseMatchups[
                                                                          index]
                                                                      .raceId
                                                                      .toString(),
                                                                  "matchup_one",
                                                                  matchup1
                                                                      .horseNo
                                                                      .toString());
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: !data.isEmpty &&
                                                                                isLeft
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .transparent)),
                                                                child:
                                                                    HorseMatchUp(
                                                                  horseName:
                                                                      matchup1
                                                                          .horseName,
                                                                  horseNo: matchup1
                                                                      .horseNo,
                                                                  jockey: "J : " +
                                                                      matchup1
                                                                          .jockey,
                                                                  star: matchup1
                                                                      .star,
                                                                  trainer: matchup1
                                                                      .trainer,
                                                                  isRight:
                                                                      false,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width: 13,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: !data.isEmpty &&
                                                                            isLeft ||
                                                                        !data.isEmpty &&
                                                                            !isLeft
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .transparent,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .grey),
                                                                shape: BoxShape
                                                                    .circle),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            child: !data.isEmpty &&
                                                                        isLeft ||
                                                                    !data.isEmpty &&
                                                                        !isLeft
                                                                ? Icon(
                                                                    FontAwesomeIcons
                                                                        .check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 12,
                                                                  )
                                                                : Text(
                                                                    "VS",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                          ),
                                                          SizedBox(
                                                            width: 13,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              print("right");
                                                              states
                                                                  .addhorseMatchUps(
                                                                state
                                                                    .horseMatchups[
                                                                        index]
                                                                    .matchups[i]
                                                                    .matchupId
                                                                    .toString(),
                                                                state
                                                                    .horseMatchups[
                                                                        index]
                                                                    .raceId
                                                                    .toString(),
                                                                "matchup_two",
                                                                matchup2.horseNo
                                                                    .toString(),
                                                              );
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: !data.isEmpty &&
                                                                                !isLeft
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .transparent)),
                                                                child:
                                                                    HorseMatchUp(
                                                                  horseName:
                                                                      matchup2
                                                                          .horseName,
                                                                  horseNo: matchup2
                                                                      .horseNo,
                                                                  jockey: "J : " +
                                                                      matchup2
                                                                          .jockey,
                                                                  star: matchup2
                                                                      .star,
                                                                  trainer: matchup2
                                                                      .trainer,
                                                                  isRight: true,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  index == state.horseMatchups.length - 1
                                      ? SizedBox(
                                          height: 100,
                                        )
                                      : Container()
                                ],
                              );
                            }),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
