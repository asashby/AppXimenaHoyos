import 'package:data/sources/token_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStoreImp implements TokenStore {
  final store = FlutterSecureStorage();
  final key = "token";

  TokenStoreImp._();

  String? _currentToken;

  @override
  Future cleanToken() {
    _currentToken = "";
    return store.delete(key: key);
  }

  @override
  Future<String?> retrieveToken() async {
    if (_currentToken != null && _currentToken!.isNotEmpty) {
      return Future.value(_currentToken);
    }

    try {
      return await store.read(key: key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future storeToken(String token) {
    return store.write(key: key, value: token).then((value) {
      _currentToken = token;
    });
  }

  static final TokenStoreImp _singleton = TokenStoreImp._();

  factory TokenStoreImp() {
    return _singleton;
  }
}

class MakiTokenStore extends TokenStoreImp {
  MakiTokenStore._() : super._();

  @override
  String get key => 'maki_token';

  static final MakiTokenStore _singleton = MakiTokenStore._();

  factory MakiTokenStore() {
    return _singleton;
  }
}

class DummyStoreImp implements TokenStore {
  String? _token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3hpbWVuYS5tYWtpcG9zLmxhL2FwaS9sb2dpbi1zb2NpYWwiLCJpYXQiOjE2Mjg3MjE3NjAsImV4cCI6MTYzMTM0OTc2MCwibmJmIjoxNjI4NzIxNzYwLCJqdGkiOiJlcWU4Q0F4MEpkMUhLQkF2Iiwic3ViIjo5NywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.VCczKKRb0kuYU2BT9w16pcVrdNAe7u_DNyDFJ1qMVzE';

  @override
  Future cleanToken() async {
    _token = null;
  }

  @override
  Future<String?> retrieveToken() {
    return Future.value(_token);
  }

  @override
  Future storeToken(String token) async {
    _token = token;
  }
}
