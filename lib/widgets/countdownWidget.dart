import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inHours.toString()}:${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60)).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: GoogleFonts.roboto(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
