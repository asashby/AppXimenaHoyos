import 'package:data/models/challenge_header_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/view/challenge_detail_page.dart';
import 'package:ximena_hoyos_app/app/challenges/bloc/challenge_bloc.dart';
import 'package:ximena_hoyos_app/app/challenges/bloc/challenge_event.dart';
import 'package:ximena_hoyos_app/app/challenges/bloc/challenge_state.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/item_view.dart';
import 'package:ximena_hoyos_app/main.dart';

class ChallengePage extends StatefulWidget {
  final List<ChallengeBloc> blocs = [];

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ChallengePage(),
    );
  }

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final challengeNameSection = ['Mis Retos', 'Retos'];

  @override
  void initState() {
    initBloc();

    super.initState();
  }

  initBloc() {
    if (widget.blocs.isEmpty) {
      challengeNameSection.forEach((_) {
        widget.blocs.add(createBlocSection());
      });
    }
  }

  createBlocSection() => ChallengeBloc(
      repository: RepositoryProvider.of(context),
      authenticationRepository: RepositoryProvider.of(context));

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.blocs.asMap().forEach((key, value) {
          print(key);
          value.add(ChallengeRefreshEvent(key));
        });
        await Future.delayed(Duration(seconds: 1));
      },
      backgroundColor: Colors.black,
      color: Colors.white,
      child: BaseScaffold(
          child: BaseView(
              caption: "",
              title: "Entrenamiento",
              sliver: SliverToBoxAdapter(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 40),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _ChallengeSection(
                      bloc: widget.blocs[index],
                      sectionId: index,
                      challengeNameSection: challengeNameSection[index],
                    );
                  },
                  itemCount: challengeNameSection.length,
                ),
              ))),
    );
  }
}

class _ChallengeSection extends StatefulWidget {
  final ChallengeBloc bloc;
  final String challengeNameSection;
  final int sectionId;

  _ChallengeSection({
    Key? key,
    required this.bloc,
    required this.sectionId,
    required this.challengeNameSection,
  }) : super(key: key);

  @override
  __ChallengeSectionState createState() => __ChallengeSectionState();
}

class __ChallengeSectionState extends State<_ChallengeSection> {
  final List<ChallengeHeader> data = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Container(
        child:
            BlocBuilder<ChallengeBloc, ChallengeState>(builder: handleBuilder),
      ),
    );
  }

  Widget handleBuilder(BuildContext context, ChallengeState state) {
    Size size = MediaQuery.of(context).size;

    if (state is ChallengeInitialState) {
      BlocProvider.of<ChallengeBloc>(context)
          .add(ChallengeFetchEvent(widget.sectionId));
    }

    if (state is ChallengeInitialState || state is ChallengeLoadingState) {
      return SizedBox(
        height: 215,
        child: Center(child: Center(child: CircularProgressIndicator())),
      );
    } else if (state is ChallengeErrorState) {
      return AppErrorView(
        onPressed: () {
          BlocProvider.of<ChallengeBloc>(context)
              .add(ChallengeRefreshEvent(widget.sectionId));
        },
        height: 215,
      );
    }

    if (state is ChallengeSuccessState) {
      if (state.cleanData) {
        data.clear();
      }

      data.addAll(state.challenges);
    }

    final isEmpty = state is ChallengeSuccessState && state.challenges.isEmpty;

    return isEmpty
        ? SizedBox.shrink()
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 28),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.challengeNameSection,
                  style: Theme.of(context).textTheme.headline2,
                )
              ),
              Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 15),
                  child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 28, right: 12),
                    itemBuilder: (context, index) {
                      final header = data[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ItemView(
                          title: header.title ?? '',
                          subTitle: header.level ?? '',
                          urlImage: header.urlImage,
                          onPressed: () => _openChallengeDetail(
                              context, header, isChallengeOwned),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }

  _openChallengeDetail(BuildContext context, ChallengeHeader challengeHeader, bool owned) {
    if (challengeHeader.slug != null) {
      Navigator.of(context)
          .push(ChallengeDetailPage.route(challengeHeader.slug!, owned));
    }
  }
}
