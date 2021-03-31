import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/changePassScreen.dart';
import 'package:winx/screens/cricket/megaLeague/cricketHomeScreen.dart';
import 'package:winx/screens/getCoins.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:winx/screens/loginScreen.dart';
import 'package:winx/screens/myProfile.dart';
import 'package:winx/screens/onBoardingScreen.dart';
import 'package:winx/screens/raceMeets.dart';
import 'package:winx/screens/splashScreen.dart';
import 'package:winx/screens/timer.dart';
import 'package:winx/services/admob_services.dart';

import 'screens/cricket/matchups/matchUpsHome.dart';
import 'screens/cricket/matchups/myMatchUps.dart';
import 'screens/cricket/matchups/myPlayerInfo.dart';
import 'screens/cricket/megaLeague/playersLeaderBoard.dart';
import 'screens/cricket/megaLeague/teams.dart';
import 'screens/emailVeriScreen.dart';
import 'screens/getTransactionHistory.dart';
import 'screens/pickHorseScreen.dart';
import 'styles/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AdmobService ams = AdmobService();
  // Admob.initialize(testDeviceIds: [ams.getAdMobId()]);
  MobileAds.instance.initialize();
  if (Platform.isIOS) {
    await Admob.requestTrackingAuthorization();
  }
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception} ${details.context}  ${details.library}',
        style: TextStyle(color: Colors.yellow, fontSize: 14),
        textDirection: TextDirection.ltr,
      ),
    );
  };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<void> _isLogin(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: CricketStates()),
        ChangeNotifierProvider.value(value: HorseMegaLeagueStates()),
        ChangeNotifierProxyProvider<Auth, User>(
          create: (_) => User(),
          update: (_, auth, products) => products..upate(auth),
        ),
        ChangeNotifierProxyProvider<Auth, HorseProvider>(
          create: (_) => HorseProvider(),
          update: (_, auth, horse) => horse..upate(auth),
        ),
        ChangeNotifierProxyProvider<HorseProvider, HorseMegaLeagueStates>(
          create: (_) => HorseMegaLeagueStates(),
          update: (_, horseprovider, horsestate) =>
              horsestate..upate(horseprovider),
        ),
        ChangeNotifierProxyProvider<Auth, MatchupsCrickets>(
          create: (_) => MatchupsCrickets(),
          update: (_, auth, cricketMatchups) => cricketMatchups..upate(auth),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TURF',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<Auth>(
            builder: (context, auth, _) => FutureBuilder(
                  future: auth.isLogin(),
                  builder: (ctx, snap) {
                    print(snap.data);
                    if (snap.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (snap.connectionState == ConnectionState.done) {
                      if (snap.data ?? false) {
                        return MatchUpHome();
                      } else {
                        return OnboardingScreen();
                      }
                    }
                    return CircularProgressIndicator();
                  },
                )),
      ),
    );
  }
}
