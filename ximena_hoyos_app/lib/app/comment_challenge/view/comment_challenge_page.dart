import 'package:data/models/challenge_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/comment_challenge/bloc/comment_challenge_bloc.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class CommentChallengePage extends StatefulWidget {
  final ChallengeDetail detail;

  const CommentChallengePage({Key? key, required this.detail})
      : super(key: key);

  static Route route(ChallengeDetail detail) {
    return MaterialPageRoute<void>(
      builder: (_) => CommentChallengePage(
        detail: detail,
      ),
    );
  }

  @override
  _CommentChallengePageState createState() => _CommentChallengePageState();
}

class _CommentChallengePageState extends State<CommentChallengePage> {
  final _titleController = TextEditingController(text: '');
  final _commentController = TextEditingController(text: '');
  late CommentChallengeBloc _bloc;
  var stars = 0.0;
  var isLoading = false;

  @override
  void initState() {
    _bloc = CommentChallengeBloc(repository: context.read());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CommentChallengeBloc, CommentChallengeState>(
        listener: _onListener,
        child: BaseScaffold(
            child: BaseView(
                title: 'Reseña',
                showBackButton: true,
                sliver: SliverPadding(
                  padding:
                      const EdgeInsets.only(right: 24, left: 24, bottom: 120),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    Center(
                      child: RatingBar(
                          ignoreGestures: isLoading,
                          unratedColor: Colors.white,
                          allowHalfRating: true,
                          initialRating: 0.0,
                          minRating: 1.0,
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
                            this.stars = rating;
                          }),
                    ),
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextField(
                            controller: _titleController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white),
                            decoration: _inputDecoration(context, "Titulo")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextField(
                          enabled: !isLoading,
                          controller: _commentController,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                          maxLines: 10,
                          decoration: _inputDecoration(context, "Comentario")),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFF30D38B),
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: isLoading ? null : _onPublish,
                        height: 60,
                        minWidth: 321,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text('Publicar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Visibility(
                              visible: isLoading,
                              child: Positioned(
                                right: 10,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // _commentChallengeForm()
                  ])),
                ))),
      ),
    );
  }

  _onPublish() {
    _bloc.add(PostCommentEvent(
        title: _titleController.text,
        comment: _commentController.text,
        rating: this.stars,
        detail: widget.detail));
  }

  _onListener(BuildContext context, CommentChallengeState state) {
    switch (state.status) {
      case CommentChallengeStatus.initial:
        break;
      case CommentChallengeStatus.loading:
        setState(() {
          isLoading = true;
        });
        break;
      case CommentChallengeStatus.error:
        setState(() {
          isLoading = false;
        });
        _onErrorHandle(context, state.error!);
        break;
      case CommentChallengeStatus.success:
        setState(() {
          isLoading = false;
        });
        final snackbar = SnackBar(content: Text('Reseña publicada'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.of(context).pop();
        break;
    }
  }

  _onErrorHandle(BuildContext context, Exception exception) {
    final String message;
    if (exception is TitleEmptyException) {
      message = 'Se requiere agregar un titulo';
    } else if (exception is CommentEmptyException) {
      message = 'Se requiere escribir un comentario';
    } else if (exception is RatingRequireException) {
      message = 'Se require agregar un puntaje';
    } else if (exception is DioError) {
      message = 'No se pudo publicar el comentario';
    } else {
      message = 'Ocurrio un error inesperado ($exception}';
    }

    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  InputDecoration _inputDecoration(BuildContext context, String hintText) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: Theme.of(context).textTheme.bodyText1,
      focusColor: Colors.white,
      hintText: hintText,
      filled: true,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      fillColor: const Color(0xFFB1B1B1).withOpacity(0.24),
    );
  }
}
