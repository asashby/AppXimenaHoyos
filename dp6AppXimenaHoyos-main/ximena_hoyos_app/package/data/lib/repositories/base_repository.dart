import 'package:data/common/dio_client.dart';
import 'package:data/sources/token_store.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  final TokenStore tokenStore;
  final String baseUrl;

  BaseRepository(this.tokenStore, this.baseUrl);

  String? _curretToken;

  Dio? _dio;

  Future<Dio> get dio async {
    final token = await tokenStore.retrieveToken();
    if (_curretToken != token || _dio == null) {
      _curretToken = token;
      _dio = createHttpClient(token: _curretToken);
      _dio!.options.baseUrl = baseUrl;
    }

    return _dio!;
  }
}
