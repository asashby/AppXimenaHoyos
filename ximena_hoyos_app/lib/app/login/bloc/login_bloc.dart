import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationDataSource repository;
  final _googleSignIn = GoogleSignIn();
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  LoginBloc(this.repository) : super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield* _authenticate(event.loginType);
    }
  }

  Stream<LoginState> _authenticate(LoginType loginType) async* {
    yield LoginStateLoading(loginType);

    DataProviderResult? result;

    try {
      result = await _authenticateWithThirdParty(loginType);
    } on Exception catch (ex) {
      yield LoginStateError(ex);
    }

    if (result != null) {
      try {
        await _authenticateWithCms(result);
      } on Exception catch (ex) {
        yield LoginStateError(ex);
      }
    }
  }

  Future<DataProviderResult> _authenticateWithThirdParty(
      LoginType loginType) async {
    switch (loginType) {
      case LoginType.facebook:
        return await _loginWithFacebook();
      case LoginType.google:
        return await googleLogin();
    }
  }

  Future _authenticateWithCms(DataProviderResult dataProviderResult) async {
    await repository.logIn(dataProviderResult);
  }

  Future<DataProviderResult> _loginWithFacebook() async {
    var accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken == null || accessToken.isExpired) {
      final result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);

      if (result.status == LoginStatus.success) {
        accessToken = result.accessToken;
      } else {
        throw result.status == LoginStatus.failed
            ? Exception(result.message)
            : Exception("cancelled");
      }
    }

    return await repository.retrieveFacebookData(accessToken!.token);
  }

  Future<DataProviderResult> _loginWithGoogle() async {


    GoogleSignInAccount? account = _googleSignIn.currentUser;

    if (account == null) {
      account = await _googleSignIn.signIn();
    }

    if (account == null) {
      throw Exception("user_not_found");
    }

    return DataProviderResult(
        email: account.email,
        firstName: account.displayName ?? "",
        lastName: "",
        id: account.id,
        photoUrl: account.photoUrl,
        provider: Provider.google);
  }
  
  Future<DataProviderResult> googleLogin() async{
      final googleUser = await googleSignIn.signIn();
      //if (googleUser == null) return null;

      _user = googleUser;

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(

        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      
      return DataProviderResult(
          email: _user!.email,
          firstName: _user!.displayName ?? "",
          lastName: "",
          id: _user!.id,
          photoUrl: _user!.photoUrl,
          provider: Provider.google);
    }
}
