import 'package:data/models/tip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ximena_hoyos_app/app/blog/blog/blog_bloc.dart';
import 'package:ximena_hoyos_app/app/blog_detail/blog_detail.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';
import 'package:ximena_hoyos_app/common/item_view.dart';
import 'package:ximena_hoyos_app/common/mini_grid_view.dart';
import 'package:ximena_hoyos_app/common/rounded_image.dart';

class BlogPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlogPage(),
    );
  }

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  ScrollController? _scrollController;
  BlogBloc? _bloc;

  @override
  void initState() {
    _bloc = BlogBloc(RepositoryProvider.of(context));
    _scrollController = ScrollController(
      initialScrollOffset: _bloc!.scrollPosition,
    );
    super.initState();
  }

  @override
  void dispose() {
    _bloc!.close();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc!,
      child: RefreshIndicator(
        onRefresh: () async {
          _bloc!.add(FetchBlogsEvent(refresh: true));
          await Future.delayed(Duration(seconds: 1));
        },
        child: BaseScaffold(
            child: BaseView(
          title: 'Tips',
          caption: '',
          showBackButton: true,
          scrollController: _scrollController!
            ..addListener(() {
              _bloc!.scrollPosition = _scrollController!.position.pixels;

              if (_scrollController!.offset ==
                      _scrollController!.position.maxScrollExtent &&
                  !_bloc!.isFetching) {
                _bloc!
                  ..isFetching = true
                  ..add(FetchBlogsEvent());
              }
            }),
          slivers: [
            SliverToBoxAdapter(
              child:
                  BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
                final data = context.read<BlogBloc>().data;

                switch (state.status) {
                  case BlogStatus.initial:
                    context.read<BlogBloc>().add(FetchBlogsEvent());
                    return SizedBox.shrink();
                  case BlogStatus.loading:
                    if (data.isEmpty) {
                      return SizedBox(
                          height: 400,
                          child: Center(
                              child:
                                  Center(child: CircularProgressIndicator())));
                    }
                    break;
                  case BlogStatus.success:
                    context.read<BlogBloc>().isFetching = false;
                    if (state.page == 1) {
                      data.clear();
                    }
                    data.addAll(state.data!);
                    break;
                  case BlogStatus.error:
                    context.read<BlogBloc>().isFetching = false;
                    return AppErrorView(onPressed: () {
                      context
                          .read<BlogBloc>()
                          .add(FetchBlogsEvent(refresh: true));
                    });
                }

                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 60),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tip = data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ItemView(
                          title: tip.title,
                          subTitle: tip.subtitle,
                          urlImage: tip.mobileImage,
                          onPressed: () {
                            Navigator.of(context)
                                .push(BlogDetailPage.route(tip));
                          }),
                    );
                  },
                );
              }),
            )
          ],
        )),
      ),
    );
  }
}

class _BlogItem extends StatelessWidget {
  final Tip tip;

  const _BlogItem({
    Key? key,
    required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imagePath = tip.mobileImage ?? tip.pageImage;
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).push(BlogDetailPage.route(tip));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: imagePath != null,
              child: MiniGridView(
                children: [
                  RoundedImage(
                    imageNetwork: imagePath,
                  ),
                  RoundedImage(
                    imageNetwork: imagePath,
                  ),
                  RoundedImage(
                    imageNetwork: imagePath,
                  ),
                  RoundedImage(
                    imageNetwork: imagePath,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              tip.title,
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
