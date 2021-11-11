import 'package:data/models/profile_model.dart';

class Authentication {
  int status = -1;
  Profile? user;
  String? token;
  String? tokenMaki;

  Authentication.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? -1;
    user = json['user'] != null ? Profile.fromJson(json['user']) : null;
    token = json['token'];
    tokenMaki = json['tokenMaki'];
  }
}
