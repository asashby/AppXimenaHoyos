import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:data/models/challenges_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/plan_button.dart';
import 'package:ximena_hoyos_app/app/comment_challenge/comment_challenge.dart';
import 'package:ximena_hoyos_app/app/commentaries/view/comentaries_page.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';
import 'package:ximena_hoyos_app/app/daily_routine/view/daily_routine_page.dart';
import 'package:data/models/model.dart';
import 'package:ximena_hoyos_app/common/check_widget.dart';
import 'package:ximena_hoyos_app/main.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String slug;

  const ChallengeDetailPage({
    Key? key,
    required this.slug
  })
      : super(key: key);

  static Route route(String slug) {
    return MaterialPageRoute<void>(
      builder: (_) => ChallengeDetailPage(
        slug: slug,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ChallengeDetailBloc(
          RepositoryProvider.of(context),
          RepositoryProvider.of(context),
          RepositoryProvider.of(context)
      ),
      child: BlocBuilder<ChallengeDetailBloc, DetailState>(
          builder: (context, state) {
            switch (state.status) {
              case DetailStatus.initial:
                _fetchDetail(context);
                return SizedBox.shrink();
              case DetailStatus.error:
                print(state.error!);
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: AppErrorView(
                    onPressed: () {
                      _fetchDetail(context);
                    },
                    onClose: () {
                        Navigator.of(context).pop();
                      },
              ),
            );
          case DetailStatus.loading:
            return SizedBox(
              height: 400,
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          case DetailStatus.success:
            return _ChallengeDetailBody(
              detail: state.data!,
              exercises: state.exercises!,
              plans: state.plans!,
            );
        }
      }),
    );
  }

  _fetchDetail(BuildContext context) {
    context.read<ChallengeDetailBloc>().add(DetailFetchEvent(slug));
  }
}

class _ChallengeDetailBody extends StatefulWidget {
  final ChallengeDetail detail;
  final List<ChallengesDailyRoutine> exercises;
  final List<PlansByCourse> plans;

  const _ChallengeDetailBody(
      {
        Key? key,
        required this.detail,
        required this.exercises,
        required this.plans,
      })
      : super(key: key);

  @override
  _ChallengeDetailBodyState createState() => _ChallengeDetailBodyState();
}

class _ChallengeDetailBodyState extends State<_ChallengeDetailBody> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context
          .read<ChallengeDetailBloc>()
          .add(DetailFetchEvent(widget.detail.slug!));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Color(0xFF221b1c),
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      slivers: [
        SliverToBoxAdapter(
          child: _ChallengeBody(
            detail: widget.detail,
            plans: widget.plans,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 60),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                color: Color(0xFF221b1c),
                padding:
                    const EdgeInsets.only(bottom: 12.0, left: 28, right: 28),
                child: _DaylyRoutineView(
                  exercise: widget.exercises[index],
                  coursePaid: widget.detail.coursePaid,
                  courseId: widget.detail.id,
                ),
              );
            },
                childCount: widget.exercises.length
            ),
          ),
        ),
      ],
      imageNetwork: widget.detail.banner,
    );
  }
}

class _DaylyRoutineView extends StatelessWidget {
  final ChallengesDailyRoutine exercise;
  final int? coursePaid;
  final int? courseId;

  const _DaylyRoutineView({
    Key? key,
    required this.exercise,
    required this.coursePaid,
    required this.courseId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 88,
      color: Colors.white,
      onPressed: () async {
        if (coursePaid == 1) {
          challengeSelectedId = courseId;
          Navigator.of(context).push(DailyRoutinePage.route(exercise, courseId));
        }
      },
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: exercise.urlIcon == null
                ? Icon(
                    Icons.photo,
                    color: Colors.grey[400],
                  )
                : ClipRRect(
                    child: CachedNetworkImage(imageUrl: exercise.urlIcon!),
                    borderRadius: BorderRadius.circular(8.0),
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
                  "Día ${exercise.day}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey[500]),
                ),
                Text(exercise.title)
              ],
            ),
          ),
          CheckWidget(
            active: exercise.flagCompleteUnit,
            coursePaid: coursePaid,
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _ChallengeBody extends StatelessWidget {
  final ChallengeDetail detail;
  final List<PlansByCourse> plans;

  const _ChallengeBody({
    Key? key,
    required this.detail,
    required this.plans
  })
      : super(key: key);

  
  Future<void> showPlansDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color(0xff221c1c),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Seleccione el plan de su conveniencia:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index){
                    return PlanButton(plan: plans[index]);
                  }
                )
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF221b1c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)
          )
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            detail.subtitle ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            detail.title ?? "",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            detail.type ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 30,
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(CommentariesPage.route(detail.slug!));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                RatingBar(
                    ignoreGestures: true,
                    unratedColor: Colors.white,
                    allowHalfRating: true,
                    initialRating: detail.rating,
                    ratingWidget: RatingWidget(
                        empty: Icon(
                          Icons.star_outline_rounded,
                          color: Colors.white,
                        ),
                        half: Icon(
                          Icons.star_half_rounded,
                          color: Colors.white,
                        ),
                        full: Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                        )),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: _ChallengeAttributeView(
                    title: "Nivel",
                    value: detail.level ?? "",
                  ),
                ),
                Expanded(
                  child: _ChallengeAttributeView(
                    title: "Frecuencia",
                    value: detail.frequency ?? "",
                  ),
                ),
                Expanded(
                  child: _ChallengeAttributeView(
                    title: "Dias",
                    value: detail.days.toString(),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff20d0fc), width: 1),
                borderRadius: BorderRadius.circular(10)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              color: Color(0xff92e600),
              onPressed: () async {
                if (detail.coursePaid == 1) {
                  Navigator.push(context, CommentChallengePage.route(detail));
                } else {
                  try {
                    await showPlansDialog(context);
                  } on Exception catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reseña publicada'))
                    );
                  }
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                  detail.coursePaid == 1 ? "Comentar" : "Solicita tu plan",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Text(
            detail.description ?? "",
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  void showDialogIndicator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
            child: SimpleDialog(
              backgroundColor: Colors.black87,
              children: [_getLoadingIndicator()],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
            ),
            onWillPop: () async => false);
      },
    );
  }

  Widget _getLoadingIndicator() {
    return Center(
      child: Column(
        children: [
          Container(
              child: CircularProgressIndicator(strokeWidth: 3),
              width: 32,
              height: 32),
          SizedBox(
            height: 12,
          ),
          Text(
            'Espere un momento...',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  void hideOpenDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _ChallengeAttributeView extends StatelessWidget {
  final String value;
  final String title;
  const _ChallengeAttributeView({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
