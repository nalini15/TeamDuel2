import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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

class MatchUpLobby extends StatefulWidget {
  MatchUpLobby({Key key}) : super(key: key);

  @override
  _MatchUpLobbyState createState() => _MatchUpLobbyState();
}

class _MatchUpLobbyState extends State<MatchUpLobby> {
  DateTime selectedDate = DateTime.now();
  final ams = AdmobService();

  final f = new DateFormat('dd-MM-yyyy');

  Future<void> getCricketMatchupsData([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    matchups.cricketMatchupFetched = false;
    String dateIntial;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    // if (matchups.cricketMatchups.isEmpty) {
    //   if (matchups.matchupDates.isNotEmpty) {
    if (matchups.selecteddateTime == null) {
      var date = DateTime.fromMillisecondsSinceEpoch(
              matchups.matchupDates[0].data[0] * 1000,
              isUtc: true)
          .toLocal();
      dateIntial = f.format(date);
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
          dateIntial, "cricket", states.selectionScreen, filter);
      matchups.changeSelectedDate(
          todayTomm.isEmpty ? f.format(date) : todayTomm,
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
          dateIntial, "cricket", states.selectionScreen, filter);
      matchups.changeSelectedDate(
          todayTomm.isEmpty ? f.format(matchups.selecteddateTime) : todayTomm,
          states.selectionScreen);
    }
    //  if (date == null) {
    //   final f = new DateFormat('dd-MM-yyyy');
    //   dateIntial = f.format(DateTime.now());
    // } else {
    //   dateIntial = date;
    // }

    //   }
    // }
  }

  @override
  void initState() {
    // getCricketMatchupsData();
    super.initState();
    getCricketMatchupsData();
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
                          Text(
                            "Select  ( min 4 - Max 15) match-up to play",
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.white),
                          ),
                          Consumer<MatchupsCrickets>(builder: (con, filter, _) {
                            if (filter.getCricketMatchesData.isNotEmpty) {
                              if (states.selectedFilterCricket.isEmpty) {
                                states.selectedFilterCricket = "Filter";
                              } else {
                                states.selectedFilterCricket =
                                    states.selectedFilterCricket;
                              }
                            }
                            return Expanded(
                              child: Container(
                                height: 38,
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
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
                                              itemCount:
                                                  filter.cricketMatches.length,
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
                                                      states.chagneFilterCricket(
                                                          "${filter.getCricketMatchesData[i].seriesName}");
                                                      getCricketMatchupsData(
                                                          f.format(
                                                              selectedDate),
                                                          filter
                                                              .getCricketMatchesData[
                                                                  i]
                                                              .seriesId
                                                              .toString());
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      "${filter.getCricketMatchesData[i].seriesName}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              })),
                                    );
                                    states.selectedFilterCricket.isNotEmpty
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
                                          "${states.selectedFilterCricket.isEmpty ? "All" : states.selectedFilterCricket}",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                      // Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              states.toogleRefresh(true);

                              getCricketMatchupsData();
                              states.toogleRefresh(false);
                            },
                            child: states.isRefresh
                                ? CircularProgressIndicator()
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
                      height: 22,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    state.cricketMatchups.isEmpty
                        ? noMatchups(context)
                        : Column(
                            children: List.generate(
                                state.cricketMatchups.length, (index) {
                              // var date = DateTime.parse(state
                              //     .cricketMatchups[index].utcMatchStartTime);
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(state.cricketMatchups[index]
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
                                // if (remaining > 24) {
                                //   remaining =
                                //       date.difference(DateTime.now()).inDays;
                                //   time = 'day';
                                // }
                              }

                              return Column(
                                children: [
                                  state.cricketMatchups.length <= 3
                                      ? NativeAds(
                                          nativekey: ams.getNativeAdId(),
                                        )
                                      : Container(),
                                  Container(
                                    color: AppColors.mainColorLight,
                                    child: ExpansionTile(
                                      title: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "${state.cricketMatchups[index].matchTeamOne} VS ${state.cricketMatchups[index].matchTeamTwo}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            // Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                "$remaining $time",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      children: <Widget>[
                                        Container(
                                          color: AppColors.mainColor,
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, bottom: 20),
                                          child: Column(
                                            children: List.generate(
                                                state.cricketMatchups[index]
                                                    .matchups.length, (i) {
                                              var matchup1 = state
                                                  .cricketMatchups[index]
                                                  .matchups[i]
                                                  .matchupOne;
                                              var matchup2 = state
                                                  .cricketMatchups[index]
                                                  .matchups[i]
                                                  .matchupTwo;

                                              var data = states.cricketMatchups
                                                  .where((element) =>
                                                      element['matchup_id'] ==
                                                      state
                                                          .cricketMatchups[
                                                              index]
                                                          .matchups[i]
                                                          .matchupId
                                                          .toString());
                                              bool isLeft = false;
                                              if (!data.isEmpty) {
                                                if (data.toList()[0]
                                                        ['playerNumber'] ==
                                                    matchup1.playerId) {
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
                                                    // color: AppColors.mainColorLight,
                                                    margin: EdgeInsets.only(
                                                        bottom: 10, top: 10),
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
                                                                  .cricketMatchups[
                                                                      index]
                                                                  .matchups[i]
                                                                  .matchupId);
                                                              print("left");
                                                              states.addcricketMatchUps(
                                                                  state
                                                                      .cricketMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchupId
                                                                      .toString(),
                                                                  state
                                                                      .cricketMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchid
                                                                      .toString(),
                                                                  "matchup_one",
                                                                  matchup1
                                                                      .playerId);
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
                                                                            ? Colors.green
                                                                            : Colors.transparent)),
                                                                child: MatchUp(
                                                                  isLeft: true,
                                                                  jersey:
                                                                      matchup1
                                                                          .jersy,
                                                                  playerName:
                                                                      matchup1
                                                                          .playerName,
                                                                  playerRole:
                                                                      matchup1
                                                                          .playerRole,
                                                                  star: matchup1
                                                                      .star,
                                                                  teamName: matchup1
                                                                      .playerTeamName,
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
                                                              states.addcricketMatchUps(
                                                                  state
                                                                      .cricketMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchupId
                                                                      .toString(),
                                                                  state
                                                                      .cricketMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchid
                                                                      .toString(),
                                                                  "matchup_two",
                                                                  matchup2
                                                                      .playerId);
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
                                                                            ? Colors.green
                                                                            : Colors.transparent)),
                                                                child: MatchUp(
                                                                  isLeft: false,
                                                                  jersey:
                                                                      matchup2
                                                                          .jersy,
                                                                  playerName:
                                                                      matchup2
                                                                          .playerName,
                                                                  playerRole:
                                                                      matchup2
                                                                          .playerRole,
                                                                  star: matchup2
                                                                      .star,
                                                                  teamName: matchup2
                                                                      .playerTeamName,
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
                                ],
                              );
                            }),
                          ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
