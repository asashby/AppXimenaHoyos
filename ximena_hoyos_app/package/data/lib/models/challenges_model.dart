class Challenges {
  int? id;
  String? title;
  String? urlImage;
  String? slug;
  int? isActivated;
  String? attributes;
  String? createdAt;
  int? flagRegistered;
  int? flagCompleted;
  String? inscDate;

  Challenges(
      {this.id,
      this.title,
      this.urlImage,
      this.slug,
      this.isActivated,
      this.attributes,
      this.createdAt,
      this.flagRegistered,
      this.flagCompleted,
      this.inscDate});

  Challenges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlImage = json['url_image'];
    slug = json['slug'];
    isActivated = json['is_activated'];
    attributes = json['attributes'];
    createdAt = json['created_at'];
    flagRegistered = json['flag_registered'];
    flagCompleted = json['flag_completed'];
    inscDate = json['insc_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url_image'] = this.urlImage;
    data['slug'] = this.slug;
    data['is_activated'] = this.isActivated;
    data['attributes'] = this.attributes;
    data['created_at'] = this.createdAt;
    data['flag_registered'] = this.flagRegistered;
    data['flag_completed'] = this.flagCompleted;
    data['insc_date'] = this.inscDate;
    return data;
  }
}
