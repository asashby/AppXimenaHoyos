import 'package:data/repositories/repositories.dart'
    show
        AuthenticationDataSource,
        ChallengesRepository,
        RecipeRepository,
        SectionRepository,
        CompanyRepository,
        ProductsRepository,
        TipsRepository;
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/authentication/bloc/authentication_bloc.dart';
import 'package:ximena_hoyos_app/common/glowless_scroll_behavior.dart';
import 'package:ximena_hoyos_app/app/home/homa.dart';
import 'package:ximena_hoyos_app/app/login/view/login_page.dart';
import 'package:ximena_hoyos_app/app/splash/splash.dart';
import 'package:data/data.dart' show AuthenticationDataSource;

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (ctx) =>
                AuthenticationDataSource.repository(TokenStoreImp())),
        RepositoryProvider(create: (ctx) => SectionRepository()),
        RepositoryProvider(
            create: (ctx) => ChallengesRepository(TokenStoreImp())),
        RepositoryProvider(create: (ctx) => RecipeRepository(TokenStoreImp())),
        RepositoryProvider(create: (ctx) => TipsRepository(TokenStoreImp())),
        RepositoryProvider(create: (ctx) => ProductsRepository(TokenStoreImp())),
        RepositoryProvider(
          create: (ctx) => CompanyRepository(),
        )
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(RepositoryProvider.of(context)),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  final themeData = ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          headline2: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          headline3: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          button: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          headline4: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),
          headline5: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          headline6: TextStyle(
              color: Color(0xFF30d38b),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          bodyText1: TextStyle(
              color: Color(0xFFb1b1b1),
              fontSize: 15,
              fontWeight: FontWeight.w300),
          bodyText2: TextStyle(
              color: Color(0xFFb1b1b1),
              fontSize: 17,
              fontWeight: FontWeight.w300),
          caption: TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: Color(0xFF291f20),
      buttonColor: Color(0xFF30d38b),
      primaryColorDark: Color(0x3Db1b1b1),
      highlightColor: Color(0x22000000),
      splashColor: Color(0x55000000));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Ximena Hoyos',
      theme: themeData,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: GlowlessScrollBehavior(),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator!
                      .pushAndRemoveUntil(HomePage.route(), (route) => false);
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator!
                      .pushAndRemoveUntil(LoginPage.route(), (route) => false);
                  break;
                default:
                  break;
              }
            },
            child: child,
          ),
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
