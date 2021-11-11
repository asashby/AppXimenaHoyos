abstract class TokenStore {
  Future storeToken(String token);
  Future cleanToken();
  Future<String?> retrieveToken();
}
