import 'package:data/models/slider_item_model.dart';
import 'package:data/utils/constants.dart';
import 'package:data/repositories/base_repository.dart';

import '../sources/token_store.dart';

class SliderRepository extends BaseRepository {
  SliderRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);
  Future<List<SliderItem>> fetchSliderItems() async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    var response = await client.get(
      '/api/sliders'
    );

    Map<String, dynamic> list = Map<String, dynamic>.from(response.data);
    return (list['data'] as List).map((e) => SliderItem.fromJson(e)).toList();
    /*return (response.data as List<String, dynamic>? ?? [])
        .map((e) => SliderItem.fromJson((e)))
        .toList();*/
  }
}
