class RecipeDetail {
  final int? id;
  final String? slug;
  final String? route;
  final String title;
  final String? timeFood;
  final String? dificult;
  final String resume;
  final String description;
  final String? pageImage;
  final List<RecipeNutritionalFact> nutritionalFacts;
  final String? imageContent;
  final List<String>? ingredients;
  final String? urlVideo;
  final List<RecipeStep> steps;
  final String? publishedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  RecipeDetail.fromJson(Map<String, dynamic?> json)
      : id = json['id'],
        slug = json['slug'],
        route = json['route'],
        title = json['title'] ?? "",
        timeFood = json['time_food'],
        dificult = json['dificult'],
        resume = json['resume'] ?? "",
        description = json['description'] ?? "",
        pageImage = json['page_image'],
        nutritionalFacts = (json['nutritional_facts'] as List? ?? [])
            .map((entry) => RecipeNutritionalFact.fromJson(entry))
            .toList(),
        imageContent = json['image_content'],
        ingredients = json['ingredients'].cast<String>(),
        urlVideo = json['url_video'],
        steps = (json['steps'] as List? ?? [])
            .map((e) => RecipeStep.fromJson(e))
            .toList(),
        publishedAt = json['published_at'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['slug'] = this.slug;
  //   data['route'] = this.route;
  //   data['title'] = this.title;
  //   data['time_food'] = this.timeFood;
  //   data['dificult'] = this.dificult;
  //   data['resume'] = this.resume;
  //   data['description'] = this.description;
  //   data['page_image'] = this.pageImage;
  //   if (this.nutritionalFacts != null) {
  //     data['nutritional_facts'] = this.nutritionalFacts!.map((v) => v).toList();
  //   }
  //   data['image_content'] = this.imageContent;
  //   data['ingredients'] = this.ingredients;
  //   data['url_video'] = this.urlVideo;

  //   data['steps'] = this.steps.map((v) => v).toList();

  //   data['published_at'] = this.publishedAt;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['deleted_at'] = this.deletedAt;
  //   return data;
  // }
}

class RecipeStep {
  final int step;
  final String description;

  RecipeStep.fromJson(Map<String, dynamic> json)
      : step = json['step'] ?? -1,
        description = json['description'] ?? "";
}

class RecipeNutritionalFact {
  final String macro;
  final String quantity;

  RecipeNutritionalFact.fromJson(Map<String, dynamic> json)
      : macro = json['macro'] ?? -1,
        quantity = json['quantity'] ?? "";
}
