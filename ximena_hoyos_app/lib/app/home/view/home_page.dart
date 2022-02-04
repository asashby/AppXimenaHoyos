import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenges/view/challenges_page.dart';
import 'package:ximena_hoyos_app/app/home/homa.dart';
import 'package:ximena_hoyos_app/app/preferences/bloc/preferences_bloc.dart';
import 'package:ximena_hoyos_app/app/preferences/view/preferences_page.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/recipe_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/view/recipes_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _pages;

  _HomePageState();

  StreamController<int> current = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _initPages();
  }

  void _initPages() {
    _pages = <Widget>[
      HomeView(
        onHomeOption: (options) {
          _onItemTapped(options.index);
        },
      ),
      ChallengePage(),
      // StorePage(),
      RecipesPage(),
      PreferencePage()
    ];
  }

  void _onItemTapped(int index) {
    current.add(index);
  }

  @override
  void dispose() {
    super.dispose();
    current.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => HomeBloc(
                  companyRepository: RepositoryProvider.of(context),
                  repository: RepositoryProvider.of(context),
                  authenticationRepository: RepositoryProvider.of(context))),
          BlocProvider(
              create: (ctx) =>
                  RecipeBloc(repository: RepositoryProvider.of(context), challengesRepository: RepositoryProvider.of(context))),
          BlocProvider(
              create: (ctx) => PreferenceBloc(RepositoryProvider.of(context)))
        ],
        child: StreamBuilder<int>(
            stream: current.stream,
            initialData: 0,
            builder: (context, snapshot) {
              return _pages[snapshot.data!];
            }),
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: current.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.black87),
              child: BottomNavigationBar(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey[500],
                onTap: _onItemTapped,
                currentIndex: snapshot.data!,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.badge), label: 'Entrenamiento'),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.store), label: 'Tienda'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt), label: 'Comidas'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Perfil'),
                ],
              ),
            );
          }),
    );
  }
}
