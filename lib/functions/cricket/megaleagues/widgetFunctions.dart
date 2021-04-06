import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/screens/cricket/matchups/matchUpsHome.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:winx/widgets/cricket/matchups/matchupsPaymentWidgets.dart';

Column prizeRow(String amt, String title) {
  return Column(
    children: <Widget>[
      Text(
        "$title",
        style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
      ),
      Row(
        children: <Widget>[
          title != "Winners"
              ? Image.asset(
                  "assets/images/toppngBig.png",
                  width: 15,
                )
              : Container(),
          SizedBox(
            width: 5,
          ),
          Text(
            "$amt",
            style: GoogleFonts.roboto(fontSize: 13, color: Colors.black),
          )
        ],
      )
    ],
  );
}

Row firstRow(
    String image, String title, String date, String timmer, String matches) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Image.asset(
          image,
          width: 38,
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "$date",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Ends in",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    "  $timmer",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.roboto(
                        fontSize: 11, color: AppColors.mainColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            width: 81,
            height: 25,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffbffebf9),
            ),
            child: Text(
              "$matches Matches",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                child: Text(
                  "C",
                  style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                child: Text(
                  "S",
                  style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
            ],
          )
        ],
      )
    ],
  );
}

void showAlertDialogNoFilter(BuildContext context, [String text]) {
  showDialog(
      context: context,
      builder: (con) => CupertinoAlertDialog(
            title: Text(text == null ? "No Filter Avaible!" : text),
          ));
}

Text appbarTitle(String title) {
  return Text("$title", style: GoogleFonts.roboto(color: Colors.white));
}

Container appBarGradientContainer() {
  return Container(
    decoration: BoxDecoration(color: AppColors.mainColor),
  );
}

Container thirdRow(String rank, String teams, String pts) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "#$rank",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(
          width: 2,
        ),
        Icon(
          Icons.arrow_upward,
          color: const Color(
            0xffbb00E209,
          ),
          size: 13,
        ),
        SizedBox(
          width: 34,
        ),
        Text(
          "Team $teams",
          style: GoogleFonts.roboto(fontSize: 12),
        ),
        Spacer(),
        Text(
          "$pts pts",
          style: GoogleFonts.roboto(
              fontSize: 12, color: const Color(0xffbb777777)),
        ),
      ],
    ),
  );
}

Widget matchesBox(
    {String matchNo,
    String live,
    String imageurl1,
    String team1,
    String imageurl2,
    String team2}) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.only(bottom: 13),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      width: double.infinity,
      height: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Match $matchNo",
                style: GoogleFonts.roboto(
                    color: const Color(0xffbb777777), fontSize: 11),
              ),
              Text(
                "$live",
                style: GoogleFonts.roboto(
                    color: const Color(0xffbbFF4956), fontSize: 11),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "$imageurl1",
                    width: 44,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "$team1",
                    style: GoogleFonts.roboto(
                        fontSize: 11, color: const Color(0xffbb333333)),
                  )
                ],
              ),
              SizedBox(
                width: 17,
              ),
              Text(
                "VS",
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontSize: 12, color: const Color(0xffbb333333)),
              ),
              SizedBox(
                width: 17,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "$imageurl2",
                    width: 44,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "$team2",
                    style: GoogleFonts.roboto(
                        fontSize: 11, color: const Color(0xffbb333333)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Column jointMatchesprizes(String title, String amt) {
  return Column(
    children: <Widget>[
      Text(
        "$title",
        style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey),
      ),
      Row(
        children: <Widget>[
          Image.asset(
            "assets/images/toppngBig.png",
            width: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "$amt",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
          )
        ],
      )
    ],
  );
}

showDialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 250,
            width: 300,
            // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 21),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, FadeNavigation(widget: HomeScreen()));
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        width: double.infinity,
                        height: 64,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/toppngBig.png",
                              width: 24,
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "Mega Leagues",
                              style: GoogleFonts.roboto(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, FadeNavigation(widget: MatchUpHome()));
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        width: double.infinity,
                        height: 64,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/toppngBig.png",
                              width: 24,
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "MatchUps",
                              style: GoogleFonts.roboto(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

showDialogSubmitDialog(BuildContext context, Function sub, Function payouts) {
  // final states = Provider.of<CricketStates>(context, listen: false);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)), //this right here
          child: Consumer<MatchupsCrickets>(
            builder: (con, matchups, _) => Consumer<CricketStates>(
              builder: (context, states, _) => Container(
                height: buildHeight(context) * 0.55,
                width: buildWidth(context) * 0.90,
                color: AppColors.mainColor,
                // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Available balance",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/toppngBig.png",
                              width: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Coins.total == null ? '0' : Coins.total,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        buildSizedBox(buildHeight(context), 0.03),
                        Text(
                          "Total matchups selected: ${states.cricketMatchups.toList().length + states.horseMatchups.toList().length}",
                          style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        buildSizedBox(buildHeight(context), 0.04),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              "Invest",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Expanded(
                                child: Text(
                              "Payout type",
                              style: GoogleFonts.roboto(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // Text(
                                    //   "I bet",
                                    //   style: GoogleFonts.roboto(fontSize: 12),
                                    // ),
                                    SizedBox(
                                      width: 20,
                                    ),

                                    Container(
                                      width: 28,
                                      height: 28,
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (states.invest >= 0) {
                                            states.investType ==
                                                    InvestType.chips
                                                ? "chips"
                                                : "coins";
                                            states.increDecreInvest(false);
                                          }
                                        },
                                        child: Text(
                                          "-",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      "assets/images/toppngBig.png",
                                      width: 14,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${states.invest}",
                                        style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (states.invest <
                                              int.parse(matchups.maxpayout)) {
                                            await payouts(states.investType ==
                                                    InvestType.chips
                                                ? "chips"
                                                : "coins");
                                            states.increDecreInvest(true);
                                          }
                                        },
                                        child: Text(
                                          "+",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    await payouts(
                                        states.investType == InvestType.chips
                                            ? "chips"
                                            : "coins");
                                    states.changeInvestType();
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      color: AppColors.mainColorLight,
                                      width: 100,
                                      height: 34,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/images/toppngBig.png",
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            states.investType ==
                                                    InvestType.coins
                                                ? "Coins"
                                                : "Chips",
                                            style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            "assets/images/refresh.png",
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        buildSizedBox(buildHeight(context), 0.04),
                        Text(
                          "Payout possible: ${matchups.maxpayout}",
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        buildSizedBox(buildHeight(context), 0.03),
                        RaisedButton(
                          color: Color.fromRGBO(0, 148, 255, 0.97),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          onPressed: () {
                            // _modalBottomSheetMenu(context);
                            // submitMatchups();
                            // showDialogSubmitDialog(context);
                            sub();
                            Navigator.of(context).pop();
                          },
                          child: Text("Pay \$${states.invest}",
                              style: GoogleFonts.roboto(
                                  fontSize: 15, color: Colors.white)),
                        ),
                        // buildSizedBox(buildHeight(context), 0.03),
                      ]),
                ),
              ),
            ),
          ),
        );
      });
}

class MatchUp extends StatelessWidget {
  final String playerName;
  final String jersey;
  final String teamName;
  final String playerRole;
  final bool star;
  final isLeft;
  const MatchUp(
      {Key key,
      this.playerName,
      this.jersey,
      this.teamName,
      this.playerRole,
      this.star,
      this.isLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.mainColorLight,
      child: Container(
          width: 150,
          height: 80,
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: jersey != "null"
                        ? Image.network(
                            "$jersey",
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
                              ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "$playerName",
                                  maxLines: 2,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              star
                                  ? Icon(
                                      FontAwesomeIcons.solidStar,
                                      color: Color.fromRGBO(252, 160, 49, 1),
                                      size: 10,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Row(
              //   children: <Widget>[
              //     Text(
              //       "IND vs AUS",
              //       style: GoogleFonts.roboto(
              //         fontSize: 10,
              //       ),
              //     ),
              //     Spacer(),
              //     Text(
              //       "03h : 12m : 56s",
              //       style: GoogleFonts.roboto(
              //           fontSize: 10, color: AppColors.mainColor),
              //     ),
              //   ],
              // )
              Row(
                children: <Widget>[
                  Text(
                    "${teamName} | ",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "$playerRole",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class HorseMatchUp extends StatelessWidget {
  String horseNo;
  String horseName;
  String jockey;
  String trainer;
  bool star;
  bool isRight;
  bool isHound;
  HorseMatchUp(
      {Key key,
      this.horseName,
      this.horseNo,
      this.jockey,
      this.star,
      this.isRight,
      this.isHound,
      this.trainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color;
    if (!isHound) {
      if (horseNo == "1") {
        color = Colors.red;
      } else if (horseNo == "2") {
        color = Colors.white;
      } else if (horseNo == "3") {
        color = Colors.blue;
      } else if (horseNo == "4") {
        color = Colors.yellow;
      } else if (horseNo == "5") {
        color = Colors.green;
      } else if (horseNo == "6") {
        color = Colors.black12;
      } else if (horseNo == "7") {
        color = Colors.orange;
      } else if (horseNo == "8") {
        color = Colors.pink;
      } else if (horseNo == "9") {
        color = Colors.blue;
      } else if (horseNo == "10") {
        color = Colors.purple;
      } else if (horseNo == "11") {
        color = Colors.grey;
      } else if (horseNo == "12") {
        color = Colors.lightGreen;
      } else if (horseNo == "13") {
        color = Colors.brown;
      } else if (horseNo == "14") {
        color = Color.fromRGBO(128, 0, 0, 1);
      } else if (horseNo == "15") {
        color = Color.fromRGBO(199, 172, 138, 1);
      } else if (horseNo == "16") {
        color = Color.fromRGBO(189, 216, 224, 1);
      } else if (horseNo == "17") {
        color = Color.fromRGBO(60, 46, 88, 1);
      } else if (horseNo == "18") {
        color = Color.fromRGBO(49, 92, 48, 1);
      } else if (horseNo == "19") {
        color = Color.fromRGBO(48, 40, 65, 1);
      } else if (horseNo == "20") {
        color = Color.fromRGBO(185, 82, 146, 1);
      } else if (horseNo == "21") {
        color = Color.fromRGBO(147, 112, 219, 1);
      } else if (horseNo == "22") {
        color = Colors.black12;
      } else if (horseNo == "23") {
        color = Colors.black12;
      } else if (horseNo == "24") {
        color = Colors.black12;
      }
    } else {
      if (horseNo == "1") {
        color = Colors.red;
      } else if (horseNo == "2") {
        color = Color.fromRGBO(36, 65, 145, 1);
      } else if (horseNo == "3") {
        color = Color.fromRGBO(255, 255, 255, 1);
      } else if (horseNo == "4") {
        color = Color.fromRGBO(39, 39, 39, 1);
      } else if (horseNo == "5") {
        color = Color.fromRGBO(31, 31, 31, 1);
      } else if (horseNo == "6") {
        color = Color.fromRGBO(201, 25, 141, 1);
      } else if (horseNo == "7") {
        color = Color.fromRGBO(252, 134, 2, 1);
      } else if (horseNo == "8") {
        color = Color.fromRGBO(16, 9, 1, 1);
      } else if (horseNo == "9") {
        color = Color.fromRGBO(32, 49, 70, 0.91);
      } else if (horseNo == "10") {
        color = Color.fromRGBO(32, 49, 70, 0.91);
      }
    }

    return Card(
      color: AppColors.mainColorLight,
      elevation: 2,
      child: Container(
          width: 150,
          height: 90,
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "$horseNo",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 12),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 150 / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "$horseName",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            star
                                ? Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: Color.fromRGBO(252, 160, 49, 1),
                                    size: 10,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "$jockey",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "T : $trainer",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Center noMatchups(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: buildHeight(context) * 0.10),
            child: Text(
              "No Matchups Available",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Please Check Another Date or Sport",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 148, 255, 0.97)),
            )),
      ],
    ),
  );
}
