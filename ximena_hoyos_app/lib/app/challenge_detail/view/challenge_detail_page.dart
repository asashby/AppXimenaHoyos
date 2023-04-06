import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:data/models/challenges_exercises_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/bloc/bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/challenge_body.dart';
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
  }) : super(key: key);

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
                    child: Center(
                        child: Center(child: CircularProgressIndicator())
                    ),
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
          child: ChallengeBody(
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
                padding: const EdgeInsets.only(
                    bottom: 12.0, left: 28, right: 28
                ),
                child: _DailyRoutineView(
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

class _DailyRoutineView extends StatelessWidget {
  final ChallengesDailyRoutine exercise;
  final int? coursePaid;
  final int? courseId;

  const _DailyRoutineView({
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
