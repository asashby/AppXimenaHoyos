class Recipe {
  int id = -1;
  String? slug;
  String? route;
  String? resume;
  String? timeFood;
  String? title;
  String? pageImage;
  String? dificult;

  Recipe(
      {required this.id,
      this.slug,
      this.route,
      this.resume,
      this.timeFood,
      this.title,
      this.pageImage});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    slug = json['slug'];
    route = json['route'];
    resume = json['resume'];
    timeFood = json['time_food'] ?? '';
    title = json['title'];
    pageImage = json['page_image'];
    dificult = json['dificult'] ?? '';
  }
}
