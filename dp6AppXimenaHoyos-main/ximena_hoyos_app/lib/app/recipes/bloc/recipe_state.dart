import 'package:data/models/recipe_model.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeInitialState extends RecipeState {}

class RecipeLoadingState extends RecipeState {
  final bool clean;

  RecipeLoadingState({this.clean = false});

  @override
  List<Object> get props => [clean];
}

class RecipeSucessState extends RecipeState {
  final List<Recipe> recipes;

  RecipeSucessState(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeErrorState extends RecipeState {
  final Exception error;

  RecipeErrorState(this.error);
}
