import 'package:data/models/tip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ximena_hoyos_app/app/blog/blog/blog_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_page.dart';

class BlogDetailPage extends StatelessWidget {
  final Tip header;

  const BlogDetailPage({Key? key, required this.header}) : super(key: key);

  static Route route(Tip tipHeader) {
    return MaterialPageRoute<void>(
      builder: (_) => BlogDetailPage(
        header: tipHeader,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => BlogBloc(RepositoryProvider.of(ctx))
          ..add(FetchBlogDetailEvent(tipHeader: header)),
        child: BlocBuilder<BlogBloc, BlogState>(builder: (context, data) {
          switch (data.status) {
            case BlogStatus.initial:
              return SizedBox.shrink();
            case BlogStatus.loading:
              return SizedBox(
                height: 400,
                child:
                    Center(child: Center(child: CircularProgressIndicator())),
              );
            case BlogStatus.success:
              return _BlogBody(
                detail: data.data!.first,
              );
            case BlogStatus.error:
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: AppErrorView(
                    onPressed: () {
                      context
                          .read()<BlogBloc>()
                          .add(FetchBlogDetailEvent(tipHeader: header));
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

class _BlogBody extends StatelessWidget {
  final Tip detail;

  const _BlogBody({
    Key? key,
    required this.detail,
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
          child: _BlogContentView(
            detail: detail,
          ),
        )
      ],
      imageNetwork: detail.mobileImage,
    );
  }
}

class _BlogContentView extends StatelessWidget {
  final Tip detail;

  const _BlogContentView({Key? key, required this.detail}) : super(key: key);
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
            detail.publishedAtWithFormat,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            detail.title,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 42),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            detail.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Html(data: detail.content),
          ),
        ],
      ),
    );
  }
}
