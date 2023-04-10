import 'dart:async';
import 'package:data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:ximena_hoyos_app/app/routine/bloc/routine_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/item_exercise_card.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  static Route route(Excercise exercise) {
    return MaterialPageRoute<void>(
      builder: (_) => RoutinePage(
        exercise: exercise,
      ),
    );
  }

  final Excercise exercise;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => RoutineBloc(RepositoryProvider.of(ctx)),
      child:
          BlocConsumer<RoutineBloc, RoutineState>(listener: (context, state) {
        if (state.state == RoutineStatus.success) {
          if (context.read<RoutineBloc>().isCompleted) {
            Navigator.pop(context, "Success");
          }
        }
      }, builder: (context, state) {
        switch (state.state) {
          case RoutineStatus.initial:
            context.read<RoutineBloc>().add(FetchRoutienEvent(exercise));
            return SizedBox.shrink();
          case RoutineStatus.loading:
            return SizedBox(
              height: 400,
              child: Center(child: Center(child: CircularProgressIndicator())),
            );
          case RoutineStatus.success:
            return _RoutineContent(
              detail: state.data!,
            );
          case RoutineStatus.error:
            print(state.error!);
            return Scaffold(
              backgroundColor: Colors.black,
              body: AppErrorView(
                exception: state.error!,
                onPressed: () {
                  context.read<RoutineBloc>().add(FetchRoutienEvent(exercise));
                },
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
            );
        }
      }),
    );
  }
}

class _RoutineContent extends StatefulWidget {
  final ExerciseDetail detail;

  const _RoutineContent({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  _RoutineContentState createState() => _RoutineContentState();
}

class _RoutineContentState extends State<_RoutineContent> {
  VideoPlayerController? _controller;
  late Future _initializeVideoPlayerFuture;
  double videoHeight = 250;
  double videoWidth = 250;
  int videoRotation = 0;
  double videoAspectRatio = 16/16;
  bool isFullScreen = false;

  @override
  void initState() {
    if (widget.detail.hasVideo) {
      _controller = VideoPlayerController.network(widget.detail.urlVideo!);
      _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
        setState(() {});
      });
      _controller?.setLooping(true);
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: BaseScaffold(
        child: BaseView(
          onBackPressed: () => _onBackPressed(context),
          title: widget.detail.title,
          showBackButton: true,
          withTopMargin: false,
          slivers: [
            SliverToBoxAdapter(
              child: Visibility(
                visible: widget.detail.hasVideo,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  margin: const EdgeInsets.only(left: 28, right: 28),
                  height: videoHeight,
                  width: videoWidth,
                  child: RotatedBox(
                    quarterTurns: videoRotation,
                    child: Stack(
                      children: [
                        FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Center(
                                  child: AspectRatio(
                                    aspectRatio: videoAspectRatio,
                                    child: VideoPlayer(_controller!),
                                  ),
                              );
                            } else {
                              return SizedBox(
                                height: 200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }
                        ),
                        Positioned(
                          bottom: 0,
                          child: IconButton(
                            icon: Icon(
                              (_controller?.value.isPlaying ?? false)
                                  ? Icons.pause_outlined
                                  : Icons.play_arrow_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller!.value.isPlaying) {
                                  _controller!.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller!.play();
                                }
                              });
                            }
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.crop_rotate_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isFullScreen){
                                  videoHeight = 250;
                                  videoWidth = 250;
                                  videoAspectRatio = 16/16;
                                  videoRotation = 0;
                                  isFullScreen = false;
                                }
                                else{
                                  videoHeight = MediaQuery.of(context).size.height * 0.85;
                                  videoWidth = MediaQuery.of(context).size.width;
                                  videoAspectRatio = 16/10;
                                  videoRotation = 1;
                                  isFullScreen = true;
                                }
                              });
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 60,
                  top: 20
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final serie = widget.detail.series[index];
                    return _RoutineItem(
                      serie: serie,
                      restTime: widget.detail.timeRest,
                      detail: widget.detail,
                      unitId: widget.detail.unitId,
                      questionId: widget.detail.id,
                    );
                  },
                  childCount: widget.detail.series.length)
              ),
            )
          ],
        )
      ),
    );
  }

  _onBackPressed(BuildContext context) {
    if (context.read<RoutineBloc>().isCompleted) {
      Navigator.pop(context, "Success");
    } else {
      Navigator.pop(context);
    }
  }
}

class _RoutineItem extends StatefulWidget {
  final ExcerciseSerie serie;
  final int unitId;
  final int questionId;
  final ExerciseDetail detail;
  final String restTime;

  const _RoutineItem(
      {Key? key,
      required this.serie,
      required this.restTime,
      required this.unitId,
      required this.questionId,
      required this.detail})
      : super(key: key);

  @override
  _RoutineItemState createState() => _RoutineItemState();
}

class _RoutineItemState extends State<_RoutineItem> {
  bool rest = false;

  Timer? _timer;
  int _start = 10;

  void startTimer() {
    _start = 5; //int.tryParse(widget.restTime) ?? 10;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          context.read<RoutineBloc>().add(FinishSerieEvent(widget.unitId,
              widget.questionId, widget.serie.serie, widget.detail));

          context.read<RoutineBloc>().isResting = false;
          setState(() {
            rest = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: rest
          ? _RoutineRestView(
              time: _start,
            )
          : ItemExerciseCard(
          subtitle: "Serie ${widget.serie.serie}",
          title: "Repeticiones ${widget.serie.repetitions}",
          isAvailable: true,
          isCompleted: widget.serie.flagComplete,
          onPressed: () async {
            if (!context.read<RoutineBloc>().isResting) {
              await _showMyDialog(context, context.read<RoutineBloc>());
            }
          }
          )
    );
  }

  Future _showMyDialog(BuildContext context, RoutineBloc bloc) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Felicitaciones',
            style: TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Serie finalizada'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Todavía no',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Descansar'),
              onPressed: () {
                bloc.isResting = true;
                startTimer();
                setState(() {
                  rest = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _RoutineRestView extends StatelessWidget {
  final int time;

  const _RoutineRestView({Key? key, required this.time}) : super(key: key);
  Widget build(BuildContext context) {
    String formatted = "${time > 9 ? "" : "0"}$time";

    return Container(
      padding: EdgeInsets.only(left: 24, right: 24),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
          color: Color(0xFF30d38b),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Descanso",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 24),
                ),
                Text(
                    "00:$formatted",
                    style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
