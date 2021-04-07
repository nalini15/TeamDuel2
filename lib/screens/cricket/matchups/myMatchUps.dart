import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/screens/cricket/matchups/myPlayerInfo.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/adBanner.dart';

class MyMatchUps extends StatefulWidget {
  final String matchupId;
  MyMatchUps({Key key, this.matchupId}) : super(key: key);

  @override
  _MyMatchUpsState createState() => _MyMatchUpsState();
}

class _MyMatchUpsState extends State<MyMatchUps> {
  final ams = AdmobService();
  Future<void> getMatchupDetails() async {
    final matchup = Provider.of<MatchupsCrickets>(context, listen: false);
    final res = await matchup.getUserMatchupDetail(widget.matchupId);
    if (!res['status']) {
      // showCupertinoPop(res, context);
    } else {
      showCupertinoPop(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          "My Matchups",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: SafeArea(
          bottom: false,
          child: FutureBuilder(
            future: getMatchupDetails(),
            builder: (con, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  )
                : Consumer<MatchupsCrickets>(
                    builder: (con, match, _) => Column(
                      children: <Widget>[
                        Container(
                          height: 70,
                          // color: AppColors.mainColorLight,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Total Winnings",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 11),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/toppngBig.png",
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          "${match.joinedMatchupsDetail[0].totalWinnings}",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15))
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Matchups won",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontSize: 11),
                                  ),
                                  Text(
                                      "${match.joinedMatchupsDetail[0].wonCount}",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Matchups Lost",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontSize: 11),
                                  ),
                                  Text(
                                      "${match.joinedMatchupsDetail[0].lostCount}",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15)),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          color: Colors.black,
                          child: Center(
                            child: AdBanner(
                              stringKey: ams.getBannerAppId(),
                              size: AdmobBannerSize.FULL_BANNER,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<MatchupsCrickets>(
                          builder: (con, matchup, _) => Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.mainColorLight),
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            height: double.infinity,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: matchup
                                    .getJoinedMatchupsDetail[0].data.length,
                                itemBuilder: (con, i) {
                                  var data =
                                      matchup.getJoinedMatchupsDetail[0].data;
                                  var matchupOne = data[i].matchupOne;
                                  var matchupTwo = data[i].matchupTwo;
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Column(
                                        children: <Widget>[
                                          i == 0
                                              ? Container()
                                              : Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset(
                                                data[i].type == "hound"
                                                    ? "assets/images/hound.png"
                                                    : data[i].type == "cricket"
                                                        ? "assets/images/bat.png"
                                                        : "assets/images/horse.png",
                                                width: 16,
                                              ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Text(
                                                "${data[i].raceDetails.raceName} (${data[i].raceDetails.raceDate})",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: 25,
                                                width: 73,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9)),
                                                child: Text(
                                                  "${data[i].raceDetails.raceStatus}",
                                                  style: GoogleFonts.roboto(
                                                    color: "${data[i].raceDetails.raceStatus} " ==
                                                            "Won"
                                                        ? Colors.green
                                                        : data[i]
                                                                    .raceDetails
                                                                    .raceStatus ==
                                                                "Lost"
                                                            ? Colors.red
                                                            : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 25),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text("${matchupOne.horseName}",
                                                    style: GoogleFonts.roboto(
                                                      color:
                                                          AppColors.buttonColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                          height: 25,
                                                          width: 25,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3)),
                                                          child: data[i].type ==
                                                                  "cricket"
                                                              ? Container(
                                                                  child: Image
                                                                      .network(
                                                                  matchupOne
                                                                      .jersy,
                                                                ))
                                                              : Text(
                                                                  "${data[i].raceId}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    // color: Colors.white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                )),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (data[i].type ==
                                                              "cricket") {
                                                            Navigator.of(context).push(
                                                                FadeNavigation(
                                                                    widget:
                                                                        MyPlayerInfo(
                                                              matchId: data[i]
                                                                  .matchid,
                                                              playerId: data[i]
                                                                  .matchupOne
                                                                  .playerId,
                                                            )));
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 70,
                                                          child: Text(
                                                              "${matchupOne.horseName}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              )),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .solidStar,
                                                        color: Colors.yellow,
                                                        size: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          "(${matchupOne.score == "null" ? "0" : matchupOne.score})   :    (${matchupTwo.score == "null" ? "0" : matchupTwo.score})",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 25,
                                                          width: 25,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3)),
                                                          child: data[i].type ==
                                                                  "cricket"
                                                              ? Container(
                                                                  child: Image
                                                                      .network(
                                                                  matchupTwo
                                                                      .jersy,
                                                                ))
                                                              : Text(
                                                                  "${data[i].raceId}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    // color: Colors.white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                )),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (data[i].type ==
                                                              "cricket") {
                                                            Navigator.of(context).push(
                                                                FadeNavigation(
                                                                    widget:
                                                                        MyPlayerInfo(
                                                              matchId: data[i]
                                                                  .matchid,
                                                              playerId: data[i]
                                                                  .matchupTwo
                                                                  .playerId,
                                                            )));
                                                          }
                                                        },
                                                        child: Text(
                                                            "${matchupTwo.horseName}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          color: Colors.black,
                          child: Center(
                            child: AdBanner(
                              stringKey: ams.getBannerAppId(),
                              size: AdmobBannerSize.FULL_BANNER,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }
}

// ListView.builder(
//                                   itemCount: matchup
//                                       .getJoinedMatchupsDetail[0].data.length,
//                                   itemBuilder: (con, i) {
//                                     var data =
//                                         matchup.getJoinedMatchupsDetail[0].data;
//                                     var matchupOne = data[i].matchupOne;
//                                     var matchupTwo = data[i].matchupTwo;
//                                     return Column(
//                                       children: <Widget>[
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         SingleChildScrollView(
//                                           scrollDirection: Axis.horizontal,
//                                           child: Row(
//                                             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: <Widget>[
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         FadeNavigation(
//                                                             widget:
//                                                                 MyPlayerInfo()));
//                                                   },
//                                                   child: MyMatchUpsPlayers(
//                                                     isLeft: true,
//                                                     jersy: matchupOne.jersy,
//                                                     playerName: matchupOne
//                                                                 .horseName ==
//                                                             null
//                                                         ? matchupOne.playerName
//                                                         : matchupOne.horseName,
//                                                     position: matchupOne
//                                                                 .playerRole ==
//                                                             null
//                                                         ? ""
//                                                         : matchupOne.playerRole,
//                                                     score:
//                                                         matchupOne.score == null
//                                                             ? matchupOne.points
//                                                             : matchupOne.score,
//                                                     status: matchupOne.selected
//                                                         .toString(),
//                                                     teams: matchupOne
//                                                                 .playerTeamName ==
//                                                             null
//                                                         ? matchupOne.jockey
//                                                         : matchupOne
//                                                             .playerTeamName,
//                                                   )),
//                                               SizedBox(
//                                                 width: 13,
//                                               ),
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         width: 1,
//                                                         color: Colors.grey),
//                                                     shape: BoxShape.circle),
//                                                 padding: EdgeInsets.all(6),
//                                                 child: Text(
//                                                   "VS",
//                                                   style: GoogleFonts.roboto(
//                                                       fontSize: 12,
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 13,
//                                               ),
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         FadeNavigation(
//                                                             widget:
//                                                                 MyPlayerInfo()));
//                                                   },
//                                                   child: MyMatchUpsPlayers(
//                                                     isLeft: false,
//                                                     jersy: matchupTwo.jersy,
//                                                     playerName: matchupTwo
//                                                                 .horseName ==
//                                                             null
//                                                         ? matchupTwo.playerName
//                                                         : matchupTwo.horseName,
//                                                     position: matchupTwo
//                                                                 .playerRole ==
//                                                             null
//                                                         ? ""
//                                                         : matchupTwo.playerRole,
//                                                     score:
//                                                         matchupTwo.score == null
//                                                             ? matchupTwo.points
//                                                             : matchupTwo.score,
//                                                     status: matchupTwo.selected
//                                                         .toString(),
//                                                     teams: matchupTwo
//                                                                 .playerTeamName ==
//                                                             null
//                                                         ? matchupTwo.jockey
//                                                         : matchupTwo
//                                                             .playerTeamName,
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   })
class MyMatchUpsPlayers extends StatelessWidget {
  final String jersy;
  final String playerName;
  final String position;
  final String teams;
  final String status;
  final String score;
  final bool isLeft;
  const MyMatchUpsPlayers(
      {Key key,
      this.jersy,
      this.playerName,
      this.position,
      this.score,
      this.status,
      this.teams,
      this.isLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
          width: 150,
          height: 140,
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: jersy != "null"
                          ? Image.asset(
                              jersy,
                              width: 20,
                            )
                          : isLeft
                              ? Image.asset(
                                  "assets/images/playerPlaceholderLeft.jpeg",
                                  width: 20,
                                )
                              : Image.asset(
                                  "assets/images/playerPlaceholderRight.jpeg",
                                  width: 20,
                                )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$playerName',
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$position",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                          style: GoogleFonts.roboto(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Spacer(),
              SizedBox(
                height: 9,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$teams",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      status == "true" ? "Live" : "Completed",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 10, color: AppColors.mainColor),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Score: ",
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "$score",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 10, color: AppColors.mainColor),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
