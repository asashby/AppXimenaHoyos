class HelpCenter {
  String? slug;
  String? title;
  String? seoImage;
  String? seoTitle;
  String? description;
  String? seoDescription;

  HelpCenter(
      {this.slug,
      this.title,
      this.seoImage,
      this.seoTitle,
      this.description,
      this.seoDescription});

  HelpCenter.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
    seoImage = json['seoImage'];
    seoTitle = json['seoTitle'];
    description = json['description'];
    seoDescription = json['seoDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['seoImage'] = this.seoImage;
    data['seoTitle'] = this.seoTitle;
    data['description'] = this.description;
    data['seoDescription'] = this.seoDescription;
    return data;
  }
}
