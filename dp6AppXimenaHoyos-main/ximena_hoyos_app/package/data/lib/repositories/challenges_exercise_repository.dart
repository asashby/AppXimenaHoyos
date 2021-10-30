import 'package:data/models/challenges_exercises_model.dart';
import 'package:data/common/dio_client.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';

class ChallengeExerciseRepository {
  final TokenStore _tokenStore;

  ChallengeExerciseRepository(this._tokenStore);

  Future<ChallengesDailyRoutine> getExercisesByChallenge(String slug) async {
    var token = await _tokenStore.retrieveToken();
    return createHttpClient(token: token)
        .get('$API_CMS/api/courses/$slug/units')
        .then((result) => ChallengesDailyRoutine.fromJson(result.data));
  }
}
