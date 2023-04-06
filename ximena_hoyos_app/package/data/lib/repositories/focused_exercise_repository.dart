import 'package:data/models/challenge_plan.dart';
import 'package:data/models/focused_exercise.dart';
import 'package:data/models/page_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';

class FocusedExerciseRepository extends BaseRepository {
  FocusedExerciseRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<bool> getCurrentUserIsSubscribed() async {
    var client = await this.dio;
    var response = await client.get('/api/focused-exercises/is-user-subscribed');
    if(response.statusCode == 200)
    {
      var responseData = response.data;
      return responseData['data'];
    }
    return false;
  }

  Future<List<PlansByCourse>> fetchFocusedExercisePlans() async {
    final client = await this.dio;

    return client.get('/api/focused-exercises/plans')
        .then((value) => Page.fromJson(value.data as Map<String, dynamic>? ?? {}))
        .then((value) => value.data!.map((e) => PlansByCourse.fromJson(e)).toList());
  }

  Future<List<FocusedExercise>> fetchFocusedExercises() async {
    final client = await this.dio;

    return client.get('/api/focused-exercises')
        .then((value) => Page.fromJson(value.data as Map<String, dynamic>? ?? {}))
        .then((value) => value.data!.map((e) => FocusedExercise.fromJson(e)).toList());
  }
}