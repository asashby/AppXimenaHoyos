import 'package:data/models/recipe_detail_model.dart';
import 'package:data/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';
import 'package:ximena_hoyos_app/app/recipe_detail/bloc/bloc.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  static Route route(Recipe recipe) {
    return MaterialPageRoute<void>(
      builder: (_) => RecipeDetailPage(
        recipe: recipe,
      ),
    );
  }

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => RecipeDetailBloc(repository: RepositoryProvider.of(ctx))
        ..add(RecipeDetailFetchEvent(recipe.slug ?? "")),
      child: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
        if (state is RecipeDetailLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecipeDetailSucessState) {
          return BasePage(
            backgroundColor: Color(0xFF221b1c),
            onClosePressed: () {
              Navigator.of(context).pop();
            },
            slivers: [
              SliverToBoxAdapter(
                child: _BodyBody(
                  recipeDetail: state.recipe,
                ),
              )
            ],
            imageNetwork: state.recipe.pageImage,
          );
        } else if (state is RecipeDetailErrorState) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: AppErrorView(
                onPressed: () {
                  BlocProvider.of<RecipeDetailBloc>(context)
                      .add(RecipeDetailFetchEvent(recipe.slug ?? ""));
                },
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        }

        return SizedBox.shrink();
      }),
    );
  }
}

class _BodyBody extends StatelessWidget {
  final RecipeDetail recipeDetail;

  const _BodyBody({Key? key, required this.recipeDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF221b1c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            recipeDetail.resume,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            recipeDetail.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            recipeDetail.description,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 36,
          ),
          SizedBox(
            height: 20,
          ),
          _NutritionalInformationView(recipeDetail: recipeDetail),
          SizedBox(
            height: 20,
          ),
          _IngredientsView(ingredients: recipeDetail.ingredients),
          SizedBox(
            height: 20,
          ),
          _PreparationView(
            recipeDetail: recipeDetail,
          )
        ],
      ),
    );
  }
}

class _PreparationView extends StatelessWidget {
  const _PreparationView({
    Key? key,
    required this.recipeDetail,
  }) : super(key: key);

  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preparación',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 12,
        ),
        Visibility(
          child: _PreparationVideoButton(
            urlVideo: recipeDetail.urlVideo,
          ),
          visible: recipeDetail.urlVideo != null &&
              recipeDetail.urlVideo!.isNotEmpty,
        ),
        SizedBox(
          height: 12,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipeDetail.steps.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            var step = recipeDetail.steps[index];

            return Container(
              padding: const EdgeInsets.only(
                  top: 24, bottom: 24, right: 32, left: 32),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Paso ${step.step}",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Color(0xFF9b9b9b))),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    step.description,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

class _PreparationVideoButton extends StatelessWidget {
  const _PreparationVideoButton({
    Key? key,
    required this.urlVideo,
  }) : super(key: key);

  final String? urlVideo;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 88,
      color: Colors.white,
      onPressed: () {},
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Como hacerlo?",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.grey[500]),
                ),
                Text("Aquí te lo mostramos")
              ],
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _IngredientsView extends StatelessWidget {
  const _IngredientsView({
    Key? key,
    this.ingredients,
  }) : super(key: key);

  final List<String>? ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredientes',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 12,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ingredients!.length,
          padding: const EdgeInsets.all(0.0),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, right: 32, left: 32),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                ingredients![index],
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          },
        )
      ],
    );
  }
}

class _NutritionalInformationView extends StatelessWidget {
  const _NutritionalInformationView({
    Key? key,
    required this.recipeDetail,
  }) : super(key: key);

  final RecipeDetail recipeDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informacion nutricional',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: _mapNutritional(),
        )
      ],
    );
  }

  List<Widget> _mapNutritional() {
    return recipeDetail.nutritionalFacts.map((e) => _mapItem(e)).toList();
  }

  Widget _mapItem(RecipeNutritionalFact e) {
    return _NutritionalAttributeView(
        title: e.macro, titleColor: Colors.amber, value: e.quantity);
  }
}

class _NutritionalAttributeView extends StatelessWidget {
  final Color? titleColor;
  final String? title;
  final String? value;

  const _NutritionalAttributeView({
    Key? key,
    this.titleColor,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth / 2 - 10,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                    color: titleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value!,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 32),
              )
            ],
          ),
        ),
      );
    });
  }
}
