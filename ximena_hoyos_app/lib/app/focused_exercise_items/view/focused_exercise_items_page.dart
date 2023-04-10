import 'package:data/models/focused_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:ximena_hoyos_app/app/focused_exercise_items/bloc/focused_exercise_items_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/item_exercise_card.dart';

class FocusedExerciseItemsPage extends StatelessWidget {
  final int focusedExerciseId;

  const FocusedExerciseItemsPage({
    Key? key,
    required this.focusedExerciseId,
  }) : super(key: key);

  static Route route(int focusedExerciseId) {
    return MaterialPageRoute<void>(
      builder: (_) => FocusedExerciseItemsPage(focusedExerciseId: focusedExerciseId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => FocusedExerciseItemsBloc(
        RepositoryProvider.of(ctx),
      ),
      child: BlocBuilder<FocusedExerciseItemsBloc, FocusedExerciseItemsState>(
        builder: (context, state) {
          switch(state.status) {
            case FocusedExerciseItemsStatus.initial:
              _fetchFocusedExercise(context);
              return SizedBox.shrink();
            case FocusedExerciseItemsStatus.error:
              print(state.error);
              return Scaffold(
                backgroundColor: Colors.black,
                body: AppErrorView(
                  onPressed: () {
                    _fetchFocusedExercise(context);
                  },
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                ),
              );
            case FocusedExerciseItemsStatus.loading:
              return SizedBox(
                height: 400,
                child: Center(
                    child: Center(child: CircularProgressIndicator())
                ),
              );
            case FocusedExerciseItemsStatus.success:
              return _FocusedExerciseItemsPageBody(
                focusedExercise: state.focusedExercise!,
              );
          }
        },
      ),
    );
  }

  _fetchFocusedExercise(BuildContext context) {
    context.read<FocusedExerciseItemsBloc>().add(
        FocusedExerciseItemsFetchEvent(focusedExerciseId),
    );
  }
}

class _FocusedExerciseItemsPageBody extends StatefulWidget {
  final FocusedExercise focusedExercise;

  const _FocusedExerciseItemsPageBody({
    Key? key,
    required this.focusedExercise
  }) : super(key: key);

  @override
  State<_FocusedExerciseItemsPageBody> createState() => _FocusedExerciseItemsPageBodyState();
}

class _FocusedExerciseItemsPageBodyState extends State<_FocusedExerciseItemsPageBody> {
  VideoPlayerController? _controller;
  late Future _initializeVideoPlayerFuture;
  double videoHeight = 250;
  double videoWidth = 250;
  int videoRotation = 0;
  double videoAspectRatio = 16/16;
  bool isFullScreen = false;

  @override
  void initState() {
    if (widget.focusedExercise.currentUserIsSubscribed == true && widget.focusedExercise.hasVideo) {
      _controller = VideoPlayerController.network(widget.focusedExercise.videoUrl!);
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
    return BaseScaffold(
        child: BaseView(
          onBackPressed: () => Navigator.pop(context),
          title: widget.focusedExercise.title,
          showBackButton: true,
          withTopMargin: false,
          slivers: [
            SliverToBoxAdapter(
              child: Visibility(
                visible: widget.focusedExercise.currentUserIsSubscribed == true && widget.focusedExercise.hasVideo,
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
                  final focusedExerciseItem = widget.focusedExercise.focusedExerciseItems[index];
                  return Container(
                    color: Color(0xFF221b1c),
                    padding: const EdgeInsets.only(
                        bottom: 12.0,
                    ),
                    child: ItemExerciseCard(
                      title: focusedExerciseItem.title ?? "",
                      isCompleted: true,
                      isAvailable: widget.focusedExercise.currentUserIsSubscribed == true,
                      defaultIcon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        // size: 48,
                      ),
                      iconBackgroundColor: Color(0xff95d100),
                      onPressed: () async {
                        if(widget.focusedExercise.currentUserIsSubscribed == true) {
                          print("Go to focused exercise page");
                        }
                      },
                    ),
                  );
                },
                childCount: widget.focusedExercise.focusedExerciseItems.length
                ),
              ),
            )
          ],
        )
    );
  }
}

