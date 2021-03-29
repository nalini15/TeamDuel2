import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/adBanner.dart';
import 'package:winx/widgets/cricket/matchups/nativeAds.dart';

class HoundMatchUpLobby extends StatefulWidget {
  HoundMatchUpLobby({Key key}) : super(key: key);

  @override
  _HoundMatchUpLobbyState createState() => _HoundMatchUpLobbyState();
}

class _HoundMatchUpLobbyState extends State<HoundMatchUpLobby> {
  DateTime selectedDate = DateTime.now();
  final ams = AdmobService();
  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       builder: (BuildContext context, Widget child) {
  //         return Theme(
  //           data: ThemeData.dark().copyWith(
  //             dialogBackgroundColor: Colors.black,
  //           ),
  //           child: child,
  //         );
  //       },
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   final states = Provider.of<CricketStates>(context, listen: false);
  //   states.chagneFilterHorse("");
  //   gethoundMatchups(f.format(selectedDate));
  // }

  final f = new DateFormat('dd-MM-yyyy');
  Future<void> gethoundMatchups([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    matchups.cricketMatchupFetched = false;
    String dateIntial;
    // if (matchups.houndMatchups.isEmpty) {
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
      matchups.changeSelectedDate(
          todayTomm.isEmpty ? f.format(dateToCheck) : todayTomm,
          states.selectionScreen);
      final res = await matchups.getMatchups(
          dateIntial, "hound", states.selectionScreen, filter);
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
          dateIntial, "hound", states.selectionScreen, filter);
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
  }
  //   }
  // }

  @override
  void initState() {
    gethoundMatchups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    final matchups = Provider.of<MatchupsCrickets>(context);
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
                              if (filter.getHoundMatchesLocation.isNotEmpty) {
                                if (states.selectedFilterHound.isEmpty) {
                                  states.selectedFilterHound = "Filter";
                                } else {
                                  states.selectedFilterHound =
                                      states.selectedFilterHound;
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
                                                    .houndMatchesLocation
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
                                                        states.chagneFilterHound(
                                                            "${filter.houndMatchesLocation[i].locations}");
                                                        gethoundMatchups(
                                                            f.format(
                                                                selectedDate),
                                                            filter
                                                                .houndMatchesLocation[
                                                                    i]
                                                                .locations
                                                                .toString());
                                                        Navigator.of(context)
                                                            .pop();
                                                        // print(states
                                                        //     .selectedFilterHound);
                                                      },
                                                      title: Text(
                                                        "${filter.houndMatchesLocation[i].locations}",
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
                                      states.selectedFilterHound.isNotEmpty
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
                                            "${states.selectedFilterHound.isEmpty ? "All" : states.selectedFilterHound}",
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

                              gethoundMatchups();
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
                      height: 15,
                    ),
                    state.houndMatchups.isEmpty
                        ? noMatchups(context)
                        : Column(
                            children: List.generate(state.houndMatchups.length,
                                (index) {
                              var date = DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(state.houndMatchups[index]
                                          .utcMatchStartTimeStamp) *
                                      1000);

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
                                  state.houndMatchups.length <= 3
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
                                            "${state.houndMatchups[index].raceName}",
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
                                                state.houndMatchups[index]
                                                    .matchups.length, (i) {
                                              var matchup1 = state
                                                  .houndMatchups[index]
                                                  .matchups[i]
                                                  .matchupOne;
                                              var matchup2 = state
                                                  .houndMatchups[index]
                                                  .matchups[i]
                                                  .matchupTwo;

                                              var data = states.houndMatchups
                                                  .where((element) =>
                                                      element['matchup_id'] ==
                                                      state.houndMatchups[index]
                                                          .matchups[i].matchupId
                                                          .toString());
                                              bool isLeft = false;
                                              if (!data.isEmpty) {
                                                if (data.toList()[0]
                                                        ['houndNumber'] ==
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
                                                                  .houndMatchups[
                                                                      index]
                                                                  .matchups[i]
                                                                  .matchupId);
                                                              print("left");
                                                              states.addhoundMatchUps(
                                                                  state
                                                                      .houndMatchups[
                                                                          index]
                                                                      .matchups[
                                                                          i]
                                                                      .matchupId
                                                                      .toString(),
                                                                  state
                                                                      .houndMatchups[
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
                                                                  jockey: "",
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
                                                                  .addhoundMatchUps(
                                                                state
                                                                    .houndMatchups[
                                                                        index]
                                                                    .matchups[i]
                                                                    .matchupId
                                                                    .toString(),
                                                                state
                                                                    .houndMatchups[
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
                                                                  jockey: "",
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
                                  index == state.houndMatchups.length - 1
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
