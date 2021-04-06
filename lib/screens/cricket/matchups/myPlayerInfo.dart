import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/providers/matchUps.dart';

class MyPlayerInfo extends StatefulWidget {
  String matchId;
  String playerId;
  MyPlayerInfo({Key key, this.matchId, this.playerId}) : super(key: key);

  @override
  _MyPlayerInfoState createState() => _MyPlayerInfoState();
}

class _MyPlayerInfoState extends State<MyPlayerInfo> {
  Future<void> getPlayerInfo(BuildContext context) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final resp =
        await matchups.getPlayerInfoData(widget.matchId, widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Player Info",
                style: GoogleFonts.roboto(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder(
          future: getPlayerInfo(context),
          builder: (con, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ))
              : Consumer<MatchupsCrickets>(
                  builder: (con, matchup, _) => matchup.playerInfo.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "No Data Available",
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                // color: Colors.white,
                                height: 96,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          "${matchup.playerInfo[0].playerImage}"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${matchup.playerInfo[0].playerName}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${matchup.playerInfo[0].total} PTS",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                titleContainer("Batting"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 207,
                                  // color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      rowcontent(
                                          "Runs Scored (${matchup.playerInfo[0].batting.runs.number})",
                                          "${matchup.playerInfo[0].batting.runs.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Boundaries (${matchup.playerInfo[0].batting.boundaries.number})",
                                          "${matchup.playerInfo[0].batting.boundaries.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Sixes (${matchup.playerInfo[0].batting.six.number})",
                                          "${matchup.playerInfo[0].batting.six.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Total Batting",
                                          "${matchup.playerInfo[0].batting.total} PTS",
                                          true),
                                      // divider(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                titleContainer("Bowling"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 207,
                                  // color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      rowcontent(
                                          "Wickets (${matchup.playerInfo[0].bowling.wickets.number})",
                                          "${matchup.playerInfo[0].bowling.wickets.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Mainden Score (${matchup.playerInfo[0].bowling.maidenOver.number})",
                                          "${matchup.playerInfo[0].bowling.maidenOver.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "LPW Score (${matchup.playerInfo[0].bowling.lbw.number})",
                                          "${matchup.playerInfo[0].bowling.lbw.score} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Total Bowling",
                                          "${matchup.playerInfo[0].bowling.total} PTS",
                                          true),
                                      // divider(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                titleContainer("Fielding"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 207,
                                  // color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      matchup.playerInfo[0].fielding.catches ==
                                              null
                                          ? Container()
                                          : rowcontent(
                                              "Catches (${matchup.playerInfo[0].fielding.runout.number == null ? 0 : matchup.playerInfo[0].fielding.runout.number})",
                                              "${matchup.playerInfo[0].fielding.runout.score} PTS"),
                                      matchup.playerInfo[0].fielding.catches ==
                                              null
                                          ? Container()
                                          : divider(),
                                      rowcontent(
                                          "Run Out (${matchup.playerInfo[0].fielding.runout.number == null ? 0 : matchup.playerInfo[0].fielding.runout.number})",
                                          "${matchup.playerInfo[0].fielding.runout.number} PTS"),

                                      divider(),
                                      rowcontent(
                                          "Total Fielding",
                                          "${matchup.playerInfo[0].fielding.total} PTS",
                                          true),
                                      // divider(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                titleContainer("Bonus"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  // height: 207,
                                  // color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      rowcontent("Part of Playing XI",
                                          "${matchup.playerInfo[0].bonus.playingXI} PTS"),
                                      divider(),
                                      rowcontent("Part of Winning Teaming",
                                          "${matchup.playerInfo[0].bonus.winingteam} PTS"),
                                      divider(),
                                      rowcontent("Player of the Match",
                                          "${matchup.playerInfo[0].bonus.manOftheMatch} PTS"),
                                      divider(),
                                      rowcontent(
                                          "Total Bonus",
                                          "${matchup.playerInfo[0].bonus.total} PTS",
                                          true),
                                      // divider(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                ),
        ),
      )),
    );
  }

  Container titleContainer(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text("$title",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Column divider() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.white,
          // indent: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Row rowcontent(String text1, String text2, [bool isLast]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$text1",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isLast != null ? FontWeight.w600 : FontWeight.normal),
        ),
        Text(
          "$text2",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isLast != null ? FontWeight.w600 : FontWeight.normal),
        ),
      ],
    );
  }
}
