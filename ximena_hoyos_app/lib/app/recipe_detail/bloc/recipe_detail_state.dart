import 'package:data/models/recipe_detail_model.dart';
import 'package:equatable/equatable.dart';

abstract class RecipeDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeDetailInitialState extends RecipeDetailState {}

class RecipeDetailLoadingState extends RecipeDetailState {}

class RecipeDetailSucessState extends RecipeDetailState {
  final RecipeDetail recipe;

  RecipeDetailSucessState(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class RecipeDetailErrorState extends RecipeDetailState {
  final Exception error;

  RecipeDetailErrorState(this.error);
}
