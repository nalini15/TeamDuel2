import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:winx/models/cricketMatchups.dart';
import 'package:winx/models/horseMatchups.dart';
import 'package:winx/models/houndMatchups.dart';
import 'package:winx/models/howToPlay.dart';
import 'package:winx/models/joinedMatchups.dart';
import 'package:winx/models/joinedMatchupsDetail.dart';
import 'package:winx/models/matchupDates.dart';
import 'package:winx/models/playerInfo.dart';
import 'package:winx/models/prizeInfo.dart';
import 'package:winx/models/scratchCard.dart';
import 'package:winx/models/timeDateModel.dart';
import 'auth.dart';

class MatchupsCrickets extends ChangeNotifier {
  bool cricketMatchupFetched = false;
  Auth auth;
  int userId;
  String token;
  bool submitLoading = false;
  List<String> selecteddateFor = ["Today", "Today", "Today"];

  ///Data lists

  ///Selected Date
  DateTime selecteddateTime;
  bool isDropDownSelection = true;

  List<JoinedMatchupsDetail> joinedMatchupsDetail = [];
  List<JoinedMatchupsDetail> get getJoinedMatchupsDetail {
    return [...joinedMatchupsDetail];
  }

  List<JoinedMatchups> joinedMatchups = [];
  List<JoinedMatchups> get getJoinedMatchups {
    return [...joinedMatchups];
  }

  List<CricketMatchups> cricketMatchups = [];
  List<CricketMatchups> get getCricketMatchupsData {
    return [...cricketMatchups];
  }

  List<CricketMatches> cricketMatches = [];
  List<CricketMatches> get getCricketMatchesData {
    return [...cricketMatches];
  }

  List<HorseMatchups> horseMatchups = [];
  List<HorseMatchups> get getHorseMatchups {
    return [...horseMatchups];
  }

  List<HorseMatchesData> horseMatchesLocation = [];
  List<HorseMatchesData> get getHorseMatchesLocation {
    return [...horseMatchesLocation];
  }

  List<HoundMatchupsData> houndMatchups = [];
  List<HoundMatchupsData> get getHoundMatchups {
    return [...houndMatchups];
  }

  List<HoundMatchesData> houndMatchesLocation = [];
  List<HoundMatchesData> get getHoundMatchesLocation {
    return [...houndMatchesLocation];
  }

  List<MatchupTimeDate> matchupTimeDate = [];
  List<MatchupTimeDate> get getMatchupTimeDate {
    return [...matchupTimeDate];
  }

  List<MatchupDates> matchupDates = [];
  List<MatchupDates> get getMatchupDates {
    return [...matchupDates];
  }

  List<String> matchdatesFormated = [];
  List<String> get getMatchdatesFormated {
    return [...matchdatesFormated];
  }

  List<PlayerInfo> playerInfo = [];
  List<PlayerInfo> get getPlayerInfo {
    return [...playerInfo];
  }

  List<PrizeInfo> prizeInfo = [];
  List<PrizeInfo> get getPrizeInfo {
    return [...prizeInfo];
  }

  List<HowToPlayModel> howPlay = [];
  List<HowToPlayModel> get getHowPlay {
    return [...howPlay];
  }

  List<ScratchCards> scratchCard = [];
  List<ScratchCards> get getScratchCard {
    return [...scratchCard];
  }

  String maxpayout = "";

  String selectedDate = "Today";

  void upate(Auth auth) async {
    this.auth = auth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.containsKey('userId')) {
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
    }
  }

  isSubmitLoading(bool value) {
    submitLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getMatchups(
      String date, String type, int selectedIndex,
      [String filter]) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
      print(userId);
      if (selectedIndex == 1) {
        type = "horse";
      } else if (selectedIndex == 2) {
        type = "cricket";
      } else {
        type = "hound";
      }
      final res = await http.get(
        filter == null
            ? 'http://api.myteamduel.com/api/v1/getMatchups/$userId/$date/$type'
            : 'http://api.myteamduel.com/api/v1/getMatchups/$userId/$date/$type/$filter',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      print(res.body);
      cricketMatchupFetched = true;
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (response['data'].isEmpty) {
        if (selectedIndex == 2) {
          cricketMatchups.clear();
          // cricketMatches.clear();
        } else if (selectedIndex == 1) {
          horseMatchups.clear();
          // horseMatchesLocation.clear();
        } else {
          houndMatchups.clear();
          // houndMatchesLocation.clear();
        }
        notifyListeners();

        resp['status'] = true;
        resp['msg'] = 'Do data available!';
        return resp;
      }
      if (selectedIndex == 2) {
        cricketMatchups.clear();
        cricketMatches.clear();
        response["data"].forEach((key, data) {
          // print(id);
          data.forEach((dat) {
            cricketMatchups.add(CricketMatchups.fromJson(dat));
          });
        });
        response["matchs"].forEach((data) {
          print(data);
          cricketMatches.add(CricketMatches.fromJson(data));
        });
      } else if (selectedIndex == 1) {
        horseMatchups.clear();
        horseMatchesLocation.clear();
        response['data'].forEach((key, data) {
          horseMatchups.add(HorseMatchups.fromJson(data));
          // print(data['matchups']);
        });

        response['locations'].forEach((data) {
          horseMatchesLocation.add(HorseMatchesData(locations: data));
        });
      } else {
        houndMatchups.clear();
        houndMatchesLocation.clear();
        response['data'].forEach((key, data) {
          houndMatchups.add(HoundMatchupsData.fromJson(data));
          // print(data['matchups']);
        });

        response['locations'].forEach((data) {
          houndMatchesLocation.add(HoundMatchesData(locations: data));
        });
      }

      print(horseMatchups.length);
      print(response['locations']);
      notifyListeners();
      resp['status'] = true;
      resp['msg'] = 'Data fetched!';
      return resp;
    } catch (e) {
      print(e.toString() + "here " + type);
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> postMatchups(dynamic jsonData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      jsonData["user_id"] = userId.toString();
      print(jsonData);
      final res = await http.post(
        'http://api.myteamduel.com/api/v1/creatematchup',
        body: json.encode(jsonData),
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }

      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getPlayerInfoData(
      String matchId, String playerId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-player-score-by-match/${this.userId}/$matchId/$playerId',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      playerInfo.clear();
      final response = json.decode(res.body) as Map<String, dynamic>;

      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      response.forEach((key, value) {
        if (key == "data") {
          playerInfo.add(PlayerInfo.fromJson(value));
        }
      });

      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> howtoPlay() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/htop',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      print(response);
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      howPlay.clear();
      howPlay.add(HowToPlayModel(
          content: response['htop'], youtube: response['youtube']));
      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> prizesInfo() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/htop/return',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      prizeInfo.clear();
      final response = json.decode(res.body) as Map<String, dynamic>;
      print(response);
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      response.forEach((key, value) {
        if (key == "data") {
          value.forEach((data) {
            prizeInfo.add(PrizeInfo.fromJson(data));
          });
        }
      });

      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  // http://app.myteamduel.com/api/v1/save-scratch-card
  Future<Map<String, dynamic>> getSratchCards() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-scratch-card/${this.userId}',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      scratchCard.clear();
      scratchCard.add(ScratchCards.fromJson(response['coins']));
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey("scratchCard")) {
        String id = sharedPreferences.getString("scratchCard");
        if (id != scratchCard[0].id) {
          scratchCard.clear();
          scratchCard.add(ScratchCards.fromJson(response['coins']));
          sharedPreferences.setString("scratchCard", scratchCard[0].id);
        } else {
          scratchCard.clear();
          // scratchCard.add(ScratchCards.fromJson(response['coins']));
        }
      } else {
        scratchCard.clear();
        scratchCard.add(ScratchCards.fromJson(response['coins']));
        sharedPreferences.setString("scratchCard", scratchCard[0].id);
      }
      print(scratchCard.length);
      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  bool scratchCardLoading = false;
  Future<Map<String, dynamic>> postScratchCard() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/save-scratch-card',
        body: {"user_id": this.userId.toString()},
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  void loadScratchCard(bool val) {
    scratchCardLoading = val;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addCoinsChips(dynamic jsonData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      jsonData["user_id"] = userId.toString();
      print(jsonData);
      final res = await http.post(
        'http://app.myteamduel.com/docs/#!/User/post_add_wallet',
        body: json.encode(jsonData),
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }

      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getUserMatchups() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getUserMatchups/$userId',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;

      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      joinedMatchups.clear();
      response['data'].forEach((value) {
        joinedMatchups.add(JoinedMatchups.fromJson(value));
      });
      print(joinedMatchups.length);
      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getUserMatchupDetail(String matchupid) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
      print(userId);
      print(matchupid);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getUserMatchupList/$userId/$matchupid',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      // if (!response['status']) {
      //   resp['status'] = false;
      //   resp['msg'] = response['msg'];
      //   return resp;
      // }
      joinedMatchupsDetail.clear();
      joinedMatchupsDetail.add(JoinedMatchupsDetail.fromJson(response));

      print(joinedMatchupsDetail[0].data.length);
      resp['status'] = false;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  //DateMatchup loading
  bool matchupDateLoading = false;
  void isLoadingMatchup(bool value) {
    matchupDateLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getMatchupDateTime() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final date = DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(DateTime.now().toString()));
      isLoadingMatchup(true);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getMatchupsDate/$userId/$date',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      isLoadingMatchup(false);
      final response = json.decode(res.body);
      matchupDates.add(MatchupDates.fromJson(response));
      if (matchupDates.isNotEmpty) {
        arrangeDates();
      }
      resp['status'] = true;
      resp['msg'] = '';
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getMaxPayout(
      int invest, String type, int matchupCount) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      var jsonData = {
        "userid": this.userId,
        "matchup_count": matchupCount,
        "return_type": type,
        "bet_amount": invest,
      };
      isSubmitLoading(true);
      final res = await http.post(
        'http://api.myteamduel.com/api/v1/getMaxPayout',
        body: json.encode(jsonData),
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      isSubmitLoading(false);

      final response = json.decode(res.body);
      if (response['status'] == false) {
        resp['status'] = false;
        resp['msg'] = 'Something went wrong please try again';
        return resp;
      }
      maxpayout = response["returnAmount"].toString();
      notifyListeners();
      resp['status'] = true;
      resp['msg'] = '';
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  void arrangeDates() async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    getMatchupDates[0].data.forEach((element) {
      var date = DateTime.fromMicrosecondsSinceEpoch(element);
      matchdatesFormated.add(formatter.format(date));
    });
  }

  void changeSelectedDate(String value, int selectedion) async {
    selectedDate = value;
    selecteddateFor[selectedion - 1] = value;
    notifyListeners();
  }
}
