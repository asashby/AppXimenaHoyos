import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:ximena_hoyos_app/app/routine/bloc/routine_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({Key? key, required this.exercise}) : super(key: key);

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
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(left: 28, right: 28),
                  height: 250,
                  width: 250,
                  child: Stack(
                    children: [
                      FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Center(
                                  child: AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
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
                          }),
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
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 28, right: 28, bottom: 60, top: 20),
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
              }, childCount: widget.detail.series.length)),
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
          : _RoutineView(
              caption: "Serie ${widget.serie.serie}",
              title: "Repeticiones ${widget.serie.repetitions}",
              isChecked: widget.serie.flagComplete,
              onPressed: () async {
                if (!context.read<RoutineBloc>().isResting) {
                  await _showMyDialog(context, context.read<RoutineBloc>());
                }
              },
            ),
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
                'Todavia no',
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

// ignore: unused_element
class _CarouselRoutines extends StatelessWidget {
  const _CarouselRoutines({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 0.7,
          enlargeStrategy: CenterPageEnlargeStrategy.height),
      items: List.generate(4, (index) {
        return Column(
          children: [
            SizedBox(
              width: 260,
              height: 170,
              child: Image.asset(
                'resources/app_background.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Ejercicio 1 de 8",
              style: Theme.of(context).textTheme.caption,
            )
          ],
        );
      }),
    );
  }
}

class _RoutineView extends StatelessWidget {
  final String? title;
  final String? caption;
  final bool isChecked;
  final VoidCallback onPressed;

  const _RoutineView(
      {Key? key,
      this.title,
      this.caption,
      this.isChecked = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        onPressed: isChecked ? null : onPressed,
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  caption!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                )
              ],
            )),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 1)),
              padding: const EdgeInsets.all(8.0),
              child: AnimatedOpacity(
                opacity: isChecked ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            )
          ],
        ),
      ),
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
      height: 70,
      decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
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
                      .headline1!
                      .copyWith(fontSize: 24),
                ),
                Text("00:$formatted",
                    style: Theme.of(context).textTheme.headline3)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
