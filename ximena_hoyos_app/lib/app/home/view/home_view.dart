import 'package:data/utils/constants.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ximena_hoyos_app/app/about/view/about_page.dart';
import 'package:ximena_hoyos_app/app/blog/view/blog_page.dart';
import 'package:ximena_hoyos_app/app/profile/profile.dart';
import 'package:ximena_hoyos_app/app/shop/shop.dart';
import 'package:ximena_hoyos_app/common/app_button.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/app/home/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/home/view/home_options.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef void OnHomeOption(HomeOptions options);

class HomeView extends StatefulWidget {
  final OnHomeOption? onHomeOption;

  const HomeView({Key? key, this.onHomeOption}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => HomeView(),
    );
  }

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => BaseScaffold(
                child: BaseView(title: "Bienvenidos", slivers: [
              SliverToBoxAdapter(
                child: Visibility(
                  visible: true,
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    color: Color(0xff202020),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32, left: 32),
                      child: Row(
                        children: [
                          ProfileButton(
                            profileImage: (state is HomeSuccess)
                                ? state.user?.urlImage
                                : null,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(ProfilePage.route());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state is HomeSuccess
                                      ? state.user?.fullName ?? ''
                                      : '',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Ver Perfil",
                                  style: TextStyle(color: Color(0xFF2ec985)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShopPage()),
                                );
                                /*final token =
                                    await MakiTokenStore().retrieveToken();
                                final link =
                                    'https://tienda.ximehoyos.com?token=$token';
                                await canLaunch(link)
                                    ? await launch(link)
                                    : throw 'Could not launch $link';*/
                              },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(BorderSide(
                                      width: 2, color: Color(0xFF2ec985))),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20)),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 30))),
                              child: Text('Tienda',
                                  style: TextStyle(
                                      color: Color(0xFF2ec985), fontSize: 14)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBody(context, state)
            ])));
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return _HomeViewLoading();
    } else if (state is HomeError) {
      return _HomeErrorView();
    } else if (state is HomeSuccess) {
      var options = state.section
          .where((element) => HOME_ROUTES.contains(element.route))
          .map((e) => _HomeOption(
                caption: '',
                imageResources: e.urlImage,
                title: e.name,
                onPressed: () {
                  switch (e.route) {
                    case OPTION_ABOUT:
                      Navigator.of(context).push(AboutPage.route());
                      break;
                    case OPTION_CHALLENGE:
                      widget.onHomeOption?.call(HomeOptions.challenged);
                      break;
                    case OPTION_BLOG:
                      Navigator.of(context).push(BlogPage.route());
                      break;
                    case OPTION_RECIPES:
                      widget.onHomeOption?.call(HomeOptions.recipes);
                      break;
                    case OPTION_TIPS:
                      Navigator.of(context).push(BlogPage.route());
                      break;
                  }
                },
              ))
          .toList();

      return _HomeMenuView(options: options);
    }
    return SizedBox.shrink();
  }
}

class _HomeErrorView extends StatelessWidget {
  const _HomeErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ha ocurrido un error inesperado, intente nuevmaente',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: AppButton(
                title: 'Reintentar',
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeFetchSection());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HomeViewLoading extends StatelessWidget {
  const _HomeViewLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Center(
      child: Center(child: CircularProgressIndicator()),
    ));
  }
}

class _HomeMenuView extends StatelessWidget {
  const _HomeMenuView({
    Key? key,
    required List<_HomeOption> options,
  })  : _options = options,
        super(key: key);

  final List<_HomeOption> _options;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 30, left: 28, right: 28, top: 20),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        itemCount: _options.length,
        itemBuilder: (context, index) {
          return _options[index];
        },
        mainAxisSpacing: 20,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      ),
    );
  }
}

class _HomeOption extends StatelessWidget {
  const _HomeOption({
    Key? key,
    this.imageResources,
    this.imageNetwork,
    this.title,
    this.caption,
    this.onPressed,
  })  : assert(imageResources == null || imageNetwork == null,
            'Solo se debe utilizar imageResources o imageNetwork, no ambos'),
        super(key: key);

  final String? imageResources;
  final String? imageNetwork;
  final String? title;
  final String? caption;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: Stack(
            children: [
              buildImage(),
              Positioned.fill(
                child: MaterialButton(
                  onPressed: onPressed as void Function()?,
                ),
              )
            ],
          ),
          borderRadius: BorderRadius.circular(23),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                caption!,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildImage() {
    if (imageResources != null) {
      return Image.asset(
        imageResources!,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      );
    } else if (imageNetwork != null) {
      return CachedNetworkImage(
        imageUrl: imageNetwork!,
        placeholder: (context, url) => SizedBox(
            width: double.infinity,
            height: 150,
            child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => SizedBox(
          width: double.infinity,
          height: 150,
          child: Center(
            child: Icon(Icons.error),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
