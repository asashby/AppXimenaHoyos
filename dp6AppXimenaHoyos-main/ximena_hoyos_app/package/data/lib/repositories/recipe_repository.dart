import 'package:data/models/page_model.dart';
import 'package:data/models/recipe_detail_model.dart';
import 'package:data/models/recipe_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';

enum RecipeFilter { none, breakfast, lunch, dinner }

extension RecipeFilterExtension on RecipeFilter {
  String get name {
    switch (this) {
      case RecipeFilter.none:
        return "Todos";
      case RecipeFilter.breakfast:
        return "Desayuno";
      case RecipeFilter.lunch:
        return "Almuerzo";
      case RecipeFilter.dinner:
        return "Cena";
    }
  }
}

class RecipeRepository extends BaseRepository {
  final Map<String, RecipeDetail> cacheRecipeDetail = {};

  RecipeRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<List<Recipe>> fetchRecipes(int page,
      {RecipeFilter filter = RecipeFilter.none, String search = ''}) async {
    var client = await dio;
    client.options.baseUrl = API_CMS;

    final query;

    if (filter == RecipeFilter.none) {
      query = {'page': page, 'search': search};
    } else {
      query = {'page': page, "time": filter.name, 'search': search};
    }

    return client
        .get('/api/recipes', queryParameters: query)
        .then((value) => Page.fromJson(value.data ?? {}))
        .then((value) =>
            value.data?.map((e) => Recipe.fromJson(e)).toList() ??
            List.empty());
  }

  Future<RecipeDetail> fetchRecipeDetail(String slug) async {
    if (cacheRecipeDetail[slug] != null) {
      return cacheRecipeDetail[slug]!;
    }

    var client = await dio;
    client.options.baseUrl = API_CMS;

    return client.get('/api/recipes/' + slug).then((value) {
      var detail = RecipeDetail.fromJson(value.data ?? {});
      cacheRecipeDetail[slug] = detail;
      return detail;
    });
  }
}
