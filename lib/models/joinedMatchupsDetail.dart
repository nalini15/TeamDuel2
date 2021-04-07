class JoinedMatchupsDetail {
  List<Data> data;
  String wonCount;
  String lostCount;
  String totalWinnings;

  JoinedMatchupsDetail(
      {this.data, this.wonCount, this.lostCount, this.totalWinnings});

  JoinedMatchupsDetail.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    wonCount = json['wonCount'].toString();
    lostCount = json['lostCount'].toString();
    totalWinnings = json['totalWinnings'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['wonCount'] = this.wonCount;
    data['lostCount'] = this.lostCount;
    data['totalWinnings'] = this.totalWinnings;
    return data;
  }
}

class Data {
  String id;
  String raceId;
  MatchupOne matchupOne;
  MatchupOne matchupTwo;
  String isAbandon;
  String type;
  RaceDetails raceDetails;
  String matchid;
  MatchDetails matchDetails;

  Data(
      {this.id,
      this.raceId,
      this.matchupOne,
      this.matchupTwo,
      this.isAbandon,
      this.type,
      this.raceDetails,
      this.matchid,
      this.matchDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    raceId = json['race_id'].toString();
    matchupOne = json['matchup_one'] != null
        ? new MatchupOne.fromJson(json['matchup_one'])
        : null;
    matchupTwo = json['matchup_two'] != null
        ? new MatchupOne.fromJson(json['matchup_two'])
        : null;
    isAbandon = json['is_abandon'];
    type = json['type'];
    raceDetails = json['race_details'] != null
        ? new RaceDetails.fromJson(json['race_details'])
        : null;
    matchid = json['matchid'].toString();
    matchDetails = json['match_details'] != null
        ? new MatchDetails.fromJson(json['match_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['race_id'] = this.raceId;
    if (this.matchupOne != null) {
      data['matchup_one'] = this.matchupOne.toJson();
    }
    if (this.matchupTwo != null) {
      data['matchup_two'] = this.matchupTwo.toJson();
    }
    data['is_abandon'] = this.isAbandon;
    data['type'] = this.type;
    if (this.raceDetails != null) {
      data['race_details'] = this.raceDetails.toJson();
    }
    data['matchid'] = this.matchid;
    if (this.matchDetails != null) {
      data['match_details'] = this.matchDetails.toJson();
    }
    return data;
  }
}

class MatchupOne {
  String horseNo;
  String horseName;
  String jockey;
  String trainer;
  bool selected;
  bool star;
  bool winner;
  String score;
  String playerId;
  String playerName;
  String playerTeamName;
  String playerRole;
  String jersy;
  String points;

  MatchupOne(
      {this.horseNo,
      this.horseName,
      this.jockey,
      this.trainer,
      this.selected,
      this.star,
      this.winner,
      this.score,
      this.playerId,
      this.playerName,
      this.playerTeamName,
      this.playerRole,
      this.jersy,
      this.points});

  MatchupOne.fromJson(Map<String, dynamic> json) {
    horseNo = json['horse_no'].toString();
    horseName = json['horse_name'].toString();
    jockey = json['jockey'].toString();
    trainer = json['trainer'].toString();
    selected = json['selected'];
    star = json['star'];
    winner = json['winner'];
    score = json['score'].toString();
    playerId = json['player_id'].toString();
    playerName = json['player_name'].toString();
    playerTeamName = json['player_team_name'].toString();
    playerRole = json['player_role'].toString();
    jersy = json['jersy'].toString();
    points = json['points'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horse_no'] = this.horseNo;
    data['horse_name'] = this.horseName;
    data['jockey'] = this.jockey;
    data['trainer'] = this.trainer;
    data['selected'] = this.selected;
    data['star'] = this.star;
    data['winner'] = this.winner;
    data['score'] = this.score;
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['player_team_name'] = this.playerTeamName;
    data['player_role'] = this.playerRole;
    data['jersy'] = this.jersy;
    data['points'] = this.points;
    return data;
  }
}

class RaceDetails {
  String raceId;
  String raceName;
  String raceDate;
  String raceStartTime;
  String raceEndTime;
  String raceLocation;
  String raceCountry;
  String raceStatus;
  String winStatus;

  RaceDetails(
      {this.raceId,
      this.raceName,
      this.raceDate,
      this.raceStartTime,
      this.raceEndTime,
      this.raceLocation,
      this.raceCountry,
      this.winStatus,
      this.raceStatus});

  RaceDetails.fromJson(Map<String, dynamic> json) {
    raceId = json['race_id'].toString();
    raceName = json['race_name'].toString();
    raceDate = json['race_date'].toString();
    raceStartTime = json['race_start_time'].toString();
    raceEndTime = json['race_end_time'].toString();
    raceLocation = json['race_location'].toString();
    raceCountry = json['race_country'].toString();
    raceStatus = json['race_status'].toString();
    raceStatus = json['win_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['race_id'] = this.raceId;
    data['race_name'] = this.raceName;
    data['race_date'] = this.raceDate;
    data['race_start_time'] = this.raceStartTime;
    data['race_end_time'] = this.raceEndTime;
    data['race_location'] = this.raceLocation;
    data['race_country'] = this.raceCountry;
    data['race_status'] = this.raceStatus;
    return data;
  }
}

class MatchDetails {
  String matchId;
  String matchTeamOne;
  String matchTeamTwo;
  String matchDate;
  String matchStartTime;
  String matchEndTime;
  String matchStatus;

  MatchDetails(
      {this.matchId,
      this.matchTeamOne,
      this.matchTeamTwo,
      this.matchDate,
      this.matchStartTime,
      this.matchEndTime,
      this.matchStatus});

  MatchDetails.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'].toString();
    matchTeamOne = json['match_team_one'].toString();
    matchTeamTwo = json['match_team_two'].toString();
    matchDate = json['match_date'].toString();
    matchStartTime = json['match_start_time'].toString();
    matchEndTime = json['match_end_time'].toString();
    matchStatus = json['match_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match_team_one'] = this.matchTeamOne;
    data['match_team_two'] = this.matchTeamTwo;
    data['match_date'] = this.matchDate;
    data['match_start_time'] = this.matchStartTime;
    data['match_end_time'] = this.matchEndTime;
    data['match_status'] = this.matchStatus;
    return data;
  }
}
