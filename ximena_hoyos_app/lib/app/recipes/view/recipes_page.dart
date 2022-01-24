import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/bloc.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/recipe_bloc.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/recipe_event.dart';

import 'nutritional_guide_view.dart';

class RecipesPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => RecipesPage(),
    );
  }

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  ScrollController? scrollController;
  final searchController = TextEditingController(text: '');
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
        initialScrollOffset:
            BlocProvider.of<RecipeBloc>(context).scrollPosition);
    searchController.addListener(() => _onTextChange(context));
  }

  @override
  void dispose() {
    scrollController!.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        var bloc = BlocProvider.of<RecipeBloc>(context);
        bloc.add(RecipeRefreshEvent());
        await bloc.stream
            .firstWhere((element) => !(element is RecipeLoadingState));
      },
      backgroundColor: Colors.black,
      color: Colors.white,
      child: BaseScaffold(
          child: BaseView(
        title: 'Comidas',
        caption: '',
        scrollController: scrollController!
          ..addListener(() {
            final RecipeBloc bloc = context.read();

            bloc.scrollPosition = scrollController!.position.pixels;

            if (scrollController!.offset ==
                    scrollController!.position.maxScrollExtent &&
                !bloc.isFetching) {
              bloc
                ..isFetching = true
                ..add(RecipeFetchEvent());
            }
          }),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                NutritionalGuideView(
                  searchController: searchController,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  _onTextChange(BuildContext context) {
    final RecipeBloc bloc = context.read();

    final search =
        searchController.text.length > 2 ? searchController.text : '';

    print('prev: ${bloc.search} - new: $search');

    if (bloc.search == search) {
      return;
    }

    _timer?.cancel();

    bloc.search = search;

    _timer = Timer(Duration(milliseconds: 500), () => _handleTimeout(context));
  }

  _handleTimeout(BuildContext context) {
    final RecipeBloc bloc = context.read();
    bloc.add(RecipeRefreshEvent());
  }
}
