import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:data/common/dio_client.dart';
import 'package:data/common/provider.dart';
import 'package:data/models/authenticate_model.dart';
import 'package:data/models/profile_model.dart';
import 'package:data/sources/token_store.dart';
import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class HttpErrorException implements Exception {
  final int statusCode;
  final String code;
  final String message;

  HttpErrorException.fromJson(dynamic data)
      : statusCode = data['statusCode'] ?? -1,
        code = data['code'] ?? '',
        message = data['message'] ?? '';
}

class AuthenticationRepository implements AuthenticationDataSource {
  final _controller = StreamController<bool>();
  final TokenStore _tokenStore;

  AuthenticationRepository(this._tokenStore);

  @override
  Stream<bool> get isLogged async* {
    final token = await _tokenStore.retrieveToken();
    yield token != null;
    yield* _controller.stream;
  }

  @override
  Future<Profile?> get user async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    try {
      final file = File('$path/user.txt');
      final contents = await file.readAsString();
      final data = json.decode(contents);
      return Profile.fromJson(data);
    } catch (ex) {
      return null;
    }
  }

  Future _setUser(Profile? newUser) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    final file = File('$path/user.txt');

    if (newUser != null) {
      print(newUser.name);
      final data = json.encode(newUser);
      await file.writeAsString(data);
    } else {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  @override
  Future logIn(DataProviderResult dataProviderResult) async {
    final path = '$API_CMS/api/login-social';

    Authentication? credential;
    try {
      final result = await createHttpClient().post(path, data: {
        'email': dataProviderResult.email,
        'password': base64.encode(utf8.encode(dataProviderResult.id)),
        'name': dataProviderResult.firstName,
        'last_name': dataProviderResult.lastName,
        'origin': dataProviderResult.provider.name,
        'url_image': dataProviderResult.photoUrl
      });
      credential = Authentication.fromJson(result.data);
    } on DioError catch (e) {
      if (e.response!.data is String) {
        throw HttpErrorException.fromJson({'message': e.response!.data});
      }
      throw HttpErrorException.fromJson(e.response!.data);
    }
    if (credential.token != null && credential.user != null) {
      await _tokenStore.storeToken(credential.token!);
      //await MakiTokenStore().storeToken(credential.tokenMaki!);
      await _setUser(credential.user!);
    } else {
      throw Exception("NO_TOKEN");
    }

    _controller.add(true);
  }

  @override
  Future<DataProviderResult> retrieveFacebookData(String accessToken) {
    final parameters = {
      "fields": "id,first_name,last_name,email",
      "access_token": accessToken
    };

    return createHttpClient()
        .get('https://graph.facebook.com/v7.0/me', queryParameters: parameters)
        .then((value) => json.decode(value.data))
        .then((value) => DataProviderResult.fromJson(value));
  }

  @override
  Future logOut() async {
    final token = await _tokenStore.retrieveToken();
    final dio = createHttpClient(token: token);
    try {
      await dio.post('$API_CMS/api/logout');
    } on DioError catch (e) {
      if (e.response!.statusCode != 401) {
        throw e;
      }
    }
    await _tokenStore.cleanToken();
    await _setUser(null);
    _controller.add(false);
  }

  @override
  void dispose() => _controller.close();
}

class DataProviderResult {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Provider provider;
  final String? photoUrl;

  DataProviderResult(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.provider,
      this.photoUrl});

  static DataProviderResult fromJson(dynamic data) {
    final id = data['id'].toString();
    return DataProviderResult(
        id: id,
        firstName: data["first_name"],
        lastName: data["last_name"],
        email: data["email"],
        provider: Provider.facebook,
        photoUrl:
            "https://graph.facebook.com/$id/picture?type=large&width=256&height=256");
  }
}

abstract class AuthenticationDataSource {
  Stream<bool> get isLogged;

  Future<Profile?> get user;

  /// Este metodo debe implementar el consumo del servicio de login y almacenamiento
  /// seguro del token de autenticacion.
  Future logIn(DataProviderResult dataProviderResult);

  Future<DataProviderResult> retrieveFacebookData(String accessToken);

  Future logOut();

  void dispose();

  factory AuthenticationDataSource.repository(TokenStore tokenStore) =>
      AuthenticationRepository(tokenStore);
}
