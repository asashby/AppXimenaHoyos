import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Dio createHttpClient({String? token}) {
  Dio dio = Dio();
  dio.options.contentType = Headers.jsonContentType;
  dio.options.responseType = ResponseType.json;
  if (token != null) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }
  _addInterceptor(dio);
  return dio;
}

final Logger _logger = Logger();

_addInterceptor(Dio dio) {
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    _logger.i({
      'URL': options.uri.toString(),
      'QueryString': options.queryParameters,
      "Header": options.headers,
      "Body": options.data,
      "Method": options.method
    });
    return handler.next(options);
  }, onResponse: (response, handler) async {
    _logger.i({
      'URL': response.requestOptions.uri.toString(),
      'statusCode': response.statusCode,
      'body': response.data
    });
    return handler.next(response);
  }, onError: (e, handler) async {
    if (e is DioError) {
      _logger.e(e.response);
    } else {
      _logger.e(e);
    }

    return handler.next(e);
  }));
}
