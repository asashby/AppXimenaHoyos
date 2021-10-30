import 'package:data/models/about_model.dart';
import 'package:data/models/page_model.dart';
import 'package:data/models/tip_model.dart';
import 'package:data/models/profile_model.dart';
import 'package:data/repositories/base_repository.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';

class TipsRepository extends BaseRepository {
  TipsRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);

  Future<List<Tip>> fetchTips(int page) async {
    final client = await dio;

    final response =
        await client.get('/api/tips', queryParameters: {'page': page});
    final data = Page.fromJson(response.data);
    final tips =
        data.data?.map((e) => Tip.fromJson(e)).toList() ?? List.empty();

    return tips;
  }

  Future<Tip?> fetchTipDetail(String slug) async {
    final client = await dio;
    final response = await client.get('/api/tips/$slug');

    if (response.data == null) {
      return null;
    }

    return Tip.fromJson(response.data);
  }

  Future<About?> fetchAbout() async {
    final client = await dio;
    final response = await client.get('/api/about/sobre-ximena');

    if (response.data == null) {
      return null;
    }

    return About.fromJson(response.data);
  }

  Future<Profile?> fetchProfile() async {
    final client = await dio;
    final response = await client.get('/api/current');

    if (response.data == null || response.data['user'] == null) {
      return null;
    }

    return Profile.fromJson(response.data['user']);
  }

  Future updateProfile(ProfileUpdateRaw updateRaw) async {
    final client = await dio;
    await client.post('/api//current/update', data: updateRaw.toJson());
  }
}
