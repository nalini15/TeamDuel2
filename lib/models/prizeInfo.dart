class PrizeInfo {
  int matchupCount;
  int coins;
  int chips;

  PrizeInfo({this.matchupCount, this.coins, this.chips});

  PrizeInfo.fromJson(Map<String, dynamic> json) {
    matchupCount = json['matchup_count'];
    coins = json['coins'];
    chips = json['chips'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchup_count'] = this.matchupCount;
    data['coins'] = this.coins;
    data['chips'] = this.chips;
    return data;
  }
}
