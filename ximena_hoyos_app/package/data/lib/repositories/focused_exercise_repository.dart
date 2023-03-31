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
}