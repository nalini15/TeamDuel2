class ScratchCards {
  String id;
  String userId;
  String amount;
  String usedStatus;
  String expireStatus;
  String createdAt;
  String updatedAt;

  ScratchCards(
      {this.id,
      this.userId,
      this.amount,
      this.usedStatus,
      this.expireStatus,
      this.createdAt,
      this.updatedAt});

  ScratchCards.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    amount = json['amount'].toString();
    usedStatus = json['used_status'].toString();
    expireStatus = json['expire_status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['used_status'] = this.usedStatus;
    data['expire_status'] = this.expireStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
