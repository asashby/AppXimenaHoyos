import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ximena_hoyos_app/app/commentaries/bloc/commentaries_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class CommentariesPage extends StatelessWidget {
  final String challengeSlug;

  const CommentariesPage({Key? key, required this.challengeSlug})
      : super(key: key);

  static Route route(String challengeSlug) {
    return MaterialPageRoute<void>(
      builder: (_) => CommentariesPage(
        challengeSlug: challengeSlug,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) =>
          CommentBloc(ctx.read())..add(FetchCommentEvent(challengeSlug)),
      child: BaseScaffold(
          child: BaseView(
        showBackButton: true,
        withTopMargin: false,
        title: 'Comentarios',
        sliver: SliverToBoxAdapter(
          child:
              BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
            switch (state.status) {
              case CommentStatus.initial:
                return SizedBox.shrink();
              case CommentStatus.loading:
                return SizedBox(
                  height: 400,
                  child:
                      Center(child: Center(child: CircularProgressIndicator())),
                );
              case CommentStatus.success:
                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final comment = state.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: _CommentaryItem(
                          content: comment.content,
                          rating: comment.rating,
                          title: comment.title,
                        ),
                      );
                    },
                    itemCount: state.data!.length);
              case CommentStatus.error:
                print(state.exception!);
                return AppErrorView(
                  height: 450,
                  exception: state.exception!,
                  onPressed: () {
                    context
                        .read<CommentBloc>()
                        .add(FetchCommentEvent(challengeSlug));
                  },
                );
            }
          }),
        ),
      )),
    );
  }
}

class _CommentaryItem extends StatelessWidget {
  final String title, rating, content;

  const _CommentaryItem({
    Key? key,
    required this.title,
    required this.rating,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(this.rating);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar(
            itemSize: 24,
            initialRating: rating,
            ignoreGestures: true,
            allowHalfRating: true,
            unratedColor: Colors.white,
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
            onRatingUpdate: (rating) {}),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "", // Fecha de comentario
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
