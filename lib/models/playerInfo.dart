class PlayerInfo {
  String playerName;
  String playerTeamName;
  String playerRole;
  String playerImage;
  Batting batting;
  Bowling bowling;
  Fielding fielding;
  Bonus bonus;
  double total;

  PlayerInfo(
      {this.playerName,
      this.playerTeamName,
      this.playerRole,
      this.playerImage,
      this.batting,
      this.bowling,
      this.fielding,
      this.bonus,
      this.total});

  PlayerInfo.fromJson(Map<String, dynamic> json) {
    playerName = json['player_name'];
    playerTeamName = json['player_team_name'];
    playerRole = json['player_role'].toString();
    playerImage = json['player_image'];
    batting =
        json['batting'] != null ? new Batting.fromJson(json['batting']) : null;
    bowling =
        json['bowling'] != null ? new Bowling.fromJson(json['bowling']) : null;
    fielding = json['fielding'] != null
        ? new Fielding.fromJson(json['fielding'])
        : null;
    bonus = json['bonus'] != null ? new Bonus.fromJson(json['bonus']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_name'] = this.playerName;
    data['player_team_name'] = this.playerTeamName;
    data['player_role'] = this.playerRole;
    data['player_image'] = this.playerImage;
    if (this.batting != null) {
      data['batting'] = this.batting.toJson();
    }
    if (this.bowling != null) {
      data['bowling'] = this.bowling.toJson();
    }
    if (this.fielding != null) {
      data['fielding'] = this.fielding.toJson();
    }
    if (this.bonus != null) {
      data['bonus'] = this.bonus.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Batting {
  double total;
  Boundaries boundaries;
  Boundaries six;
  Boundaries runs;
  double strikerate;
  dynamic halfCentury;
  dynamic above75;
  dynamic century;
  dynamic oneHalfCentury;
  dynamic doubleCentury;

  Batting(
      {this.total,
      this.boundaries,
      this.six,
      this.runs,
      this.strikerate,
      this.halfCentury,
      this.above75,
      this.century,
      this.oneHalfCentury,
      this.doubleCentury});

  Batting.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    boundaries = json['boundaries'] != null
        ? new Boundaries.fromJson(json['boundaries'])
        : null;
    six = json['six'] != null ? new Boundaries.fromJson(json['six']) : null;
    runs = json['runs'] != null ? new Boundaries.fromJson(json['runs']) : null;
    strikerate = json['strikerate'];
    halfCentury = json['half_century'];
    above75 = json['above_75'];
    century = json['century'];
    oneHalfCentury = json['one_half_century'];
    doubleCentury = json['double_century'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.boundaries != null) {
      data['boundaries'] = this.boundaries.toJson();
    }
    if (this.six != null) {
      data['six'] = this.six.toJson();
    }
    if (this.runs != null) {
      data['runs'] = this.runs.toJson();
    }
    data['strikerate'] = this.strikerate;
    data['half_century'] = this.halfCentury;
    data['above_75'] = this.above75;
    data['century'] = this.century;
    data['one_half_century'] = this.oneHalfCentury;
    data['double_century'] = this.doubleCentury;
    return data;
  }
}

class Boundaries {
  dynamic score;
  dynamic number;

  Boundaries({this.score, this.number});

  Boundaries.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['number'] = this.number;
    return data;
  }
}

class Bowling {
  dynamic total;
  Boundaries wickets;
  Boundaries lbw;
  Boundaries bowled;
  dynamic strikerate;
  Boundaries wicketHaul;
  Boundaries maidenOver;

  Bowling(
      {this.total,
      this.wickets,
      this.lbw,
      this.bowled,
      this.strikerate,
      this.wicketHaul,
      this.maidenOver});

  Bowling.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    wickets = json['wickets'] != null
        ? new Boundaries.fromJson(json['wickets'])
        : null;
    lbw = json['lbw'] != null ? new Boundaries.fromJson(json['lbw']) : null;
    bowled =
        json['bowled'] != null ? new Boundaries.fromJson(json['bowled']) : null;
    strikerate = json['strikerate'];
    wicketHaul = json['wicket_haul'] != null
        ? new Boundaries.fromJson(json['wicket_haul'])
        : null;
    maidenOver = json['maiden_over'] != null
        ? new Boundaries.fromJson(json['maiden_over'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.wickets != null) {
      data['wickets'] = this.wickets.toJson();
    }
    if (this.lbw != null) {
      data['lbw'] = this.lbw.toJson();
    }
    if (this.bowled != null) {
      data['bowled'] = this.bowled.toJson();
    }
    data['strikerate'] = this.strikerate;
    if (this.wicketHaul != null) {
      data['wicket_haul'] = this.wicketHaul.toJson();
    }
    if (this.maidenOver != null) {
      data['maiden_over'] = this.maidenOver.toJson();
    }
    return data;
  }
}

class Fielding {
  dynamic total;
  Boundaries runout;
  Boundaries stumped;
  Boundaries catches;

  Fielding({this.total, this.runout, this.stumped, this.catches});

  Fielding.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    runout =
        json['runout'] != null ? new Boundaries.fromJson(json['runout']) : null;
    stumped = json['stumped'] != null
        ? new Boundaries.fromJson(json['stumped'])
        : null;
    catches = json['catches'] != null
        ? new Boundaries.fromJson(json['catches'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.runout != null) {
      data['runout'] = this.runout.toJson();
    }
    if (this.stumped != null) {
      data['stumped'] = this.stumped.toJson();
    }
    if (this.catches != null) {
      data['catches'] = this.catches.toJson();
    }
    return data;
  }
}

class Bonus {
  dynamic total;
  dynamic playingXI;
  dynamic manOftheMatch;
  dynamic winingteam;

  Bonus({this.total, this.playingXI, this.manOftheMatch, this.winingteam});

  Bonus.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    playingXI = json['playingXI'];
    manOftheMatch = json['man_ofthe_match'];
    winingteam = json['winingteam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['playingXI'] = this.playingXI;
    data['man_ofthe_match'] = this.manOftheMatch;
    data['winingteam'] = this.winingteam;
    return data;
  }
}
