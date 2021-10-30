import 'package:data/repositories/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:ximena_hoyos_app/app/recipe_detail/bloc/recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final RecipeRepository repository;

  RecipeDetailBloc({required this.repository})
      : super(RecipeDetailInitialState());

  @override
  Stream<RecipeDetailState> mapEventToState(RecipeDetailEvent event) async* {
    if (event is RecipeDetailFetchEvent) {
      yield* _mapFetchEventToState(event.slug);
    }
  }

  Stream<RecipeDetailState> _mapFetchEventToState(String slug) async* {
    try {
      yield RecipeDetailLoadingState();
      var response = await repository.fetchRecipeDetail(slug);
      yield RecipeDetailSucessState(response);
    } on Exception catch (e) {
      yield RecipeDetailErrorState(e);
    }
  }
}
