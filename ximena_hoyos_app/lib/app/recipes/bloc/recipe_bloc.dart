import 'package:data/models/challenge_detail.dart';
import 'package:data/models/current_courses_model.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:data/repositories/recipe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/recipe_event.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/recipe_state.dart';
import 'package:ximena_hoyos_app/main.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  var page = 1;
  var isFetching = false;
  var filter = RecipeFilter.none;
  var search = '';
  var scrollPosition = 0.0;
  final RecipeRepository repository;
  final ChallengesRepository challengesRepository;

  RecipeBloc({required this.repository, required this.challengesRepository}) : super(RecipeInitialState());

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is RecipeFetchEvent) {
      yield* mapFetchEventToState();
    } else if (event is RecipeRefreshEvent) {
      page = 1;
      yield* mapFetchEventToState(refresh: true);
    } else if (event is RecipeApplyFilterEvent) {
      if (event.filter == filter) {
        return; // No se puede volver a repetir
      }

      page = 1;
      filter = event.filter;
      yield* mapFetchEventToState(refresh: true);
    }
  }

  Stream<RecipeState> mapFetchEventToState({bool refresh = false}) async* {
    try {
      yield RecipeLoadingState(clean: refresh);

      final search = this.search.length > 2 ? this.search : '';

      CurrentCourses currentCourses = await challengesRepository.fetchCurrentCourses();

      if(currentCourses.courseCount! > 0){
        areRecipesUnlocked = true;
      }
      else{
        areRecipesUnlocked = false;
      }

      var response =
          await repository.fetchRecipes(page, filter: filter, search: search);

      yield RecipeSucessState(response);
      page++;
    } on Exception catch (e) {
      print(e);
      yield RecipeErrorState(e);
    }
  }
}
