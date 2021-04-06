import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/adBanner.dart';

class HowToPlay extends StatefulWidget {
  HowToPlay({Key key}) : super(key: key);

  @override
  _HowToPlayState createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  Future<void> howToPlay(BuildContext context) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final resp = await matchups.howtoPlay();
    final respo = await matchups.prizesInfo();
  }

  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColorLight,
        title: appbarTitle("How to play!"),
      ),
      backgroundColor: AppColors.mainColor,
      body: Consumer<MatchupsCrickets>(
        builder: (con, matchups, _) => Column(
          children: [
            buildSizedBox(buildHeight(context), 0.02),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.mainColorLight, width: 1)),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        states.changeHowToPlay(1);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: states.howToPlay == 0
                              ? AppColors.buttonColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Prizes Info",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: states.howToPlay == 0
                                  ? Colors.black
                                  : AppColors.buttonColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        states.changeHowToPlay(0);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: 50,
                        decoration: BoxDecoration(
                          color: states.howToPlay == 1
                              ? AppColors.buttonColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "How to Play",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: states.howToPlay == 1
                                  ? Colors.black
                                  : AppColors.buttonColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildSizedBox(buildHeight(context), 0.05),
            FutureBuilder(
              future: howToPlay(context),
              builder: (con, snap) => Expanded(
                child: Column(
                  children: [
                    states.howToPlay == 0
                        ? matchups.prizeInfo.isEmpty
                            ? Center(
                                child: Text(
                                  "No Data",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: matchups.prizeInfo.length,
                                    itemBuilder: (con, index) {
                                      var data = matchups.prizeInfo[index];
                                      return Container(
                                        height: 50,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColorLight,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${data.matchupCount} Matchups",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Text("${data.coins} Times",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Image.asset(
                                                  "assets/images/toppngBig.png",
                                                  width: 30,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("${data.chips} Times",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Image.asset(
                                                  "assets/images/money.png",
                                                  width: 30,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }))
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 20, right: 20, bottom: 20),
                                child:
                                    // Html(
                                    //     data: "${matchups.howPlay[0].content}")
                                    Text(
                                  "${matchups.howPlay[0].content}",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
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
    );
  }
}
