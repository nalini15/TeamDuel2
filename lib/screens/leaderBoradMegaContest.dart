import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/widgets/matchWiseLeaderBoardHorse.dart';
import 'package:winx/widgets/totalLeaderBoardHorse.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderBoradMegaContest extends StatefulWidget {
  String appBarTitle;
  LeaderBoradMegaContest({Key key, this.appBarTitle}) : super(key: key);

  @override
  _LeaderBoradMegaContestState createState() => _LeaderBoradMegaContestState();
}

class _LeaderBoradMegaContestState extends State<LeaderBoradMegaContest>
    with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarTitle,
          style: GoogleFonts.roboto(fontSize: 15),
        ),
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text(
                "Total",
                style: GoogleFonts.roboto(fontSize: 15),
              ),
            ),
            Tab(
              child: Text(
                "Match Wise",
                style: GoogleFonts.roboto(fontSize: 15),
              ),
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
      ),
      body: SafeArea(
          child: TabBarView(
        controller: tabController,
        children: <Widget>[
          TotalLeaderBoardHorse(),
          MatchWiseLeaderBoardHorse(),
        ],
      )),
    );
  }
}
