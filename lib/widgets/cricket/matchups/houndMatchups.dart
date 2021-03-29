import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/widgets/cricket/matchups/houndLobby.dart';

import 'horseLobby.dart';
import 'matchupsJoined.dart';
import 'matchupsLobby.dart';
import 'matchupsPaymentWidgets.dart';

class HoundMatchups extends StatelessWidget {
  const HoundMatchups({
    Key key,
    @required this.states,
  }) : super(key: key);

  final CricketStates states;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // buildSizedBox(buildHeight(context), 0.02),
          // MatchUpsPayment(),
          // buildSizedBox(buildHeight(context), 0.03),
          states.matchupSection == MatchupSections.joinedmatchups
              ? MatchUpJoined()
              : HoundMatchUpLobby()
        ],
      ),
    );
  }
}
