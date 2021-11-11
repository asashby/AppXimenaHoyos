class User {
  int id = -1;
  String? name;
  String? surName;
  String? email;
  String? origin;
  String? emailVerifiedAt;
  int? isActivated;
  int? flagLogged;
  int? flagAccept;
  int? externalEnterprise;
  String? enterprise;
  // AddittionalInfo addittionalInfo;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  User(
      {required this.id,
      this.name,
      this.surName,
      this.email,
      this.origin,
      this.emailVerifiedAt,
      this.isActivated,
      this.flagLogged,
      this.flagAccept,
      this.externalEnterprise,
      this.enterprise,
      // this.addittionalInfo,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    name = json['name'];
    surName = json['sur_name'];
    email = json['email'];
    origin = json['origin'];
    emailVerifiedAt = json['email_verified_at'];
    isActivated = json['is_activated'];
    flagLogged = json['flagLogged'];
    flagAccept = json['flagAccept'];
    externalEnterprise = json['external_enterprise'];
    enterprise = json['enterprise'];
    // addittionalInfo = json['addittional_info'] != null
    //     ? new AddittionalInfo.fromJson(json['addittional_info'])
    //     : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sur_name'] = this.surName;
    data['email'] = this.email;
    data['origin'] = this.origin;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_activated'] = this.isActivated;
    data['flagLogged'] = this.flagLogged;
    data['flagAccept'] = this.flagAccept;
    data['external_enterprise'] = this.externalEnterprise;
    data['enterprise'] = this.enterprise;
    // if (this.addittionalInfo != null) {
    //   data['addittional_info'] = this.addittionalInfo.toJson();
    // }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
