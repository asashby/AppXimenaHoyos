class CulqiCharge {
  int? amount;
  String? currencyCode;
  String? email;
  String? sourceId;

  CulqiCharge({this.amount, this.currencyCode, this.email, this.sourceId});

  CulqiCharge.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currency_code'];
    email = json['email'];
    sourceId = json['source_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency_code'] = this.currencyCode;
    data['email'] = this.email;
    data['source_id'] = this.sourceId;
    return data;
  }
}