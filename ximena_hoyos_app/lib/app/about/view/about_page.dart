import 'package:data/models/about_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ximena_hoyos_app/app/about/bloc/about_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';

class AboutPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => AboutPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) =>
            AboutBloc(RepositoryProvider.of(ctx))..add(FetchAboutEvent()),
        child: BlocBuilder<AboutBloc, AboutState>(builder: (context, data) {
          switch (data.status) {
            case AboutStatus.initial:
              return SizedBox.shrink();
            case AboutStatus.loading:
              return SizedBox(
                height: 400,
                child:
                    Center(child: Center(child: CircularProgressIndicator())),
              );
            case AboutStatus.success:
              return _AboutBody(
                data: data.data!,
              );
            case AboutStatus.error:
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: AppErrorView(
                    onPressed: () {
                      context.read()<AboutBloc>().add(FetchAboutEvent());
                    },
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
          }
        }));
  }
}

class _AboutBody extends StatelessWidget {
  final About data;

  const _AboutBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Color(0xFF221b1c),
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      slivers: [
        SliverToBoxAdapter(
          child: _AboutContentView(
            data: data,
          ),
        )
      ],
      imageNetwork: data.mobileImage ?? data.pageImage,
    );
  }
}

class _AboutContentView extends StatelessWidget {
  final About data;

  const _AboutContentView({Key? key, required this.data}) : super(key: key);
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
            '',
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 32),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              data.description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.socialNetworks.entries
                  .map((e) => _AboutSocialNetWorkItem(
                      socialNetwork: e.key, link: e.value))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSocialNetWorkItem extends StatelessWidget {
  final SocialNetwork socialNetwork;
  final String link;

  const _AboutSocialNetWorkItem(
      {Key? key, required this.socialNetwork, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String icon;
    switch (socialNetwork) {
      case SocialNetwork.TIKTOK:
        icon = 'resources/ic_tiktok.png';
        break;
      case SocialNetwork.FACEBOOK:
        icon = 'resources/ic_facebook.png';
        break;
      case SocialNetwork.INSTAGRAM:
        icon = 'resources/ic_instagram.png';
        break;
      case SocialNetwork.UNKNOWN:
        return SizedBox.shrink();
      case SocialNetwork.YOUTUBE:
        icon = 'resources/ic_youtube.png';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: SizedBox(
        width: 50,
        height: 50,
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: () async {
            await canLaunch(link)
                ? await launch(link)
                : throw 'Could not launch $link';
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image(
              image: AssetImage(icon),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
