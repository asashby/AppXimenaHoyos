import 'package:data/repositories/recipe_repository.dart';

abstract class RecipeEvent {}

class RecipeFetchEvent extends RecipeEvent {}

class RecipeRefreshEvent extends RecipeEvent {}

class RecipeApplyFilterEvent extends RecipeEvent {
  final RecipeFilter filter;

  RecipeApplyFilterEvent(this.filter);
}
