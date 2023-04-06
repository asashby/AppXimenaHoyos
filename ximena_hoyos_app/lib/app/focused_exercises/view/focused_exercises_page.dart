import 'package:cached_network_image/cached_network_image.dart';
import 'package:data/models/challenge_detail.dart';
import 'package:data/models/challenge_plan.dart';
import 'package:data/models/focused_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/challenge_detail/components/challenge_body.dart';
import 'package:ximena_hoyos_app/app/focused_exercises/bloc/focused_exercises_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';
import 'package:ximena_hoyos_app/common/check_widget.dart';

class FocusedExercisesPage extends StatelessWidget {
  const FocusedExercisesPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => FocusedExercisesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => FocusedExerciseBloc(
          RepositoryProvider.of(context),
      ),
      child: BlocBuilder<FocusedExerciseBloc, FocusedExerciseState>(
        builder: (context, state) {
          switch(state.status) {
            case FocusedExerciseStatus.initial:
              _fetchFocusedExercises(context);
              return SizedBox.shrink();
            case FocusedExerciseStatus.error:
              print(state.error);
              return Scaffold(
                backgroundColor: Colors.black,
                body: AppErrorView(
                  onPressed: () {
                    _fetchFocusedExercises(context);
                  },
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                ),
              );
            case FocusedExerciseStatus.loading:
              return SizedBox(
                height: 400,
                child: Center(
                    child: Center(child: CircularProgressIndicator())
                ),
              );
            case FocusedExerciseStatus.success:
              return _FocusedExercisePageBody(
                challengeDetail: state.challengeDetail!,
                plans: state.focusedExercisePlans!,
                focusedExercises: state.focusedExercises!,
              );
          }
        },
      ),
    );
  }

  _fetchFocusedExercises(BuildContext context) {
    context.read<FocusedExerciseBloc>().add(FocusedExerciseFetchEvent());
  }
}

class _FocusedExercisePageBody extends StatefulWidget {
  final ChallengeDetail challengeDetail;
  final List<PlansByCourse> plans;
  final List<FocusedExercise> focusedExercises;
  const _FocusedExercisePageBody({
    Key? key,
    required this.challengeDetail,
    required this.plans,
    required this.focusedExercises,
  }) : super(key: key);

  @override
  State<_FocusedExercisePageBody> createState() => _FocusedExercisePageBodyState();
}

class _FocusedExercisePageBodyState extends State<_FocusedExercisePageBody> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context
          .read<FocusedExerciseBloc>()
          .add(FocusedExerciseFetchEvent());
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
            detail: widget.challengeDetail,
            plans: widget.plans,
            enableComments: false,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 60),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              final currentFocusedExercise = widget.focusedExercises[index];
              return Container(
                color: Color(0xFF221b1c),
                padding: const EdgeInsets.only(
                    bottom: 12.0, left: 28, right: 28
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 88,
                  color: Colors.white,
                  onPressed: () async {
                    if (currentFocusedExercise.currentUserIsSubscribed == true) {
                      print("Go to Focused Exercise Details Page");
                    }
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: ClipRRect(
                            child: CachedNetworkImage(imageUrl: "https://cms.ximehoyosfit.com/units/images/file-7387.jpeg",),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                      ),
                      SizedBox(
                        width: 10
                      ),
                      Expanded(
                        child: Text(currentFocusedExercise.title ?? ""),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CheckWidget(
                        active: true,
                        coursePaid: currentFocusedExercise.currentUserIsSubscribed == true ? 1 : 0,
                      )
                    ],
                  ),
                ),
              );
            },
            childCount: widget.focusedExercises.length,
            ),
          ),
        ),
      ],
      imageNetwork: "https://cms.ximehoyosfit.com//storage/mobile_image/ysQjjneE5PiRthNLq83793PXC2UggM9R5C1FJxxO.jpg",
    );
  }
}


