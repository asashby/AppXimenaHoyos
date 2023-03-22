import 'package:data/models/exchange_rate_model.dart';
import 'package:data/utils/constants.dart';
import 'package:data/repositories/base_repository.dart';

import '../sources/token_store.dart';

class ExchangeRateRepository extends BaseRepository {
  ExchangeRateRepository(TokenStore tokenStore) : super(tokenStore, API_CMS);
  Future<ExchangeRate> getExchangeRate() async {
    var client = await this.dio;
    client.options.baseUrl = API_CMS;

    var response = await client.get(
      '/api/exchange-rate'
    );

    return ExchangeRate.fromJson(response.data);
  }
}
