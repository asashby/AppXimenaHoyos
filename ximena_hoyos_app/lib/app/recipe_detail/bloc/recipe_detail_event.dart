abstract class RecipeDetailEvent {}

class RecipeDetailFetchEvent extends RecipeDetailEvent {
  final String slug;

  RecipeDetailFetchEvent(this.slug);
}
