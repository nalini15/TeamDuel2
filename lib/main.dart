import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _isLogin(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
  }

  String _message = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message ${message}');
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        displayNotification(message);
        // _showItemDialog(message);
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
  }

  Future displayNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // await Fluttertoast.showToast(
    //     msg: "Notification Clicked",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIos: 1,
    //     backgroundColor: Colors.black54,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => new CupertinoAlertDialog(
    //         title: new Text(title),
    //         content: new Text(body),
    //         actions: [
    //           CupertinoDialogAction(
    //             isDefaultAction: true,
    //             child: new Text('Ok'),
    //             onPressed: () async {
    //               Navigator.of(context, rootNavigator: true).pop();
    //               await Fluttertoast.showToast(
    //                   msg: "Notification Clicked",
    //                   toastLength: Toast.LENGTH_SHORT,
    //                   gravity: ToastGravity.BOTTOM,
    //                   timeInSecForIos: 1,
    //                   backgroundColor: Colors.black54,
    //                   textColor: Colors.white,
    //                   fontSize: 16.0
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    // );
  }
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // _register() {
  //   _firebaseMessaging.getToken().then((token) => print(token));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getMessage();
  //   _register();
  // }

  // void getMessage() {
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //     print('on message $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print('on resume $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print('on launch $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   });
  // }

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
