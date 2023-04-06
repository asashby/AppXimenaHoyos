class ChallengeHeader {
  int? id;
  String? title;
  String? urlImage;
  int? days;
  String? level;
  String? slug;
  String? frequency;

  ChallengeHeader(
      {
        this.id,
        this.title,
        this.urlImage,
        this.days,
        this.level,
        this.slug,
        this.frequency
      });

  ChallengeHeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlImage = json['url_image'];
    days = json['days'];
    level = json['level'];
    frequency = json['frequency'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url_image'] = this.urlImage;
    data['days'] = this.days;
    data['level'] = this.level;
    data['frequency'] = this.frequency;
    return data;
  }
}
