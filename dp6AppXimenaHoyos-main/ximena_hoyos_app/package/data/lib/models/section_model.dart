class Section {
  int? id;
  String? name;
  String? route;
  String? slug;
  String? textLink;
  String? urlImage;
  int? order;

  Section(
      {this.id,
      this.name,
      this.route,
      this.slug,
      this.textLink,
      this.order,
      this.urlImage});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    route = json['route'];
    slug = json['slug'];
    textLink = json['text_link'];
    order = json['order'];
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['route'] = this.route;
    data['slug'] = this.slug;
    data['text_link'] = this.textLink;
    data['order'] = this.order;
    data['url_image'] = this.urlImage;
    return data;
  }
}
