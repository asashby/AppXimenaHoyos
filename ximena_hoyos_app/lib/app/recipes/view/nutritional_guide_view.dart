import 'package:data/models/recipe_model.dart';
import 'package:data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/rounded_image.dart';
import 'package:ximena_hoyos_app/app/recipe_detail/recipe_detail.dart';
import 'package:ximena_hoyos_app/app/recipes/bloc/bloc.dart';
import 'package:ximena_hoyos_app/common/search_view.dart';

class NutritionalGuideView extends StatelessWidget {
  final List<Recipe> data = [];
  final TextEditingController searchController;
  NutritionalGuideView({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final categories = RecipeFilter.values.toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchView(controller: searchController),
        BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: categories.length,
              padding: const EdgeInsets.only(left: 28, right: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _CategoryItem(
                filter: categories[index],
                selected: BlocProvider.of<RecipeBloc>(context).filter ==
                    categories[index],
              ),
            ),
          );
        }),
        SizedBox(
          height: 32,
        ),
        BlocConsumer<RecipeBloc, RecipeState>(listener: (context, state) {
          if (state is RecipeLoadingState && state.clean) {
            data.clear();
          }
        }, builder: (context, state) {
          if (state is RecipeInitialState) {
            BlocProvider.of<RecipeBloc>(context).add(RecipeFetchEvent());
          }

          if (state is RecipeInitialState ||
              state is RecipeLoadingState && data.isEmpty) {
            return SizedBox(
              height: 400,
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          } else if (state is RecipeSucessState) {
            data.addAll(state.recipes);
            BlocProvider.of<RecipeBloc>(context).isFetching = false;
          } else if (state is RecipeErrorState) {
            BlocProvider.of<RecipeBloc>(context).isFetching = false;
            return AppErrorView(onPressed: () {
              BlocProvider.of<RecipeBloc>(context).add(RecipeRefreshEvent());
            });
          }

          if (data.isEmpty) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Text('No hay comidas'),
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 28, right: 20, bottom: 20),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _GuideItem(
                recipe: data[index],
              ),
            ),
          );
        })
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.filter,
    this.selected,
  }) : super(key: key);

  final RecipeFilter filter;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: RawMaterialButton(
        onPressed: () {
          BlocProvider.of<RecipeBloc>(context)
              .add(RecipeApplyFilterEvent(filter));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: selected! ? Color(0xff95d100) : Colors.white,
        child: Container(
            child: Text(
          this.filter.name,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: selected! ? Colors.white : Colors.black54),
        )),
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  final Recipe recipe;

  const _GuideItem({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.all(0.0),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).push(RecipeDetailPage.route(recipe));
      },
      child: Row(
        children: [
          SizedBox(
            height: 106.0,
            width: 106.0,
            child: RoundedImage(
              imageNetwork: recipe.pageImage,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              padding: const EdgeInsets.all(0.0),
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recipe.timeFood ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.grey[500]),
                    ),
                    Text(recipe.dificult!,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(recipe.title ?? ""),
              ],
            ),
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
