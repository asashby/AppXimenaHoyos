import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ximena_hoyos_app/app/profile/profile.dart';

class BaseView extends StatelessWidget {
  final Widget? sliver;
  final List<Widget>? slivers;
  final String? title;
  final String caption;
  final bool showProfileButton;
  final String? profileUrlImage;
  final bool showBackButton;
  final bool withTopMargin;
  final VoidCallback? onBackPressed;
  final ScrollController? scrollController;

  const BaseView(
      {Key? key,
      this.sliver,
      this.slivers,
      this.title,
      this.caption = "",
      this.showProfileButton = false,
      this.showBackButton = false,
      this.withTopMargin = true,
      this.scrollController,
      this.onBackPressed,
      this.profileUrlImage})
      : assert(sliver == null || slivers == null,
            'Solo se debe utilizar slivers o sliver, no ambos'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers;
    if (this.slivers != null) {
      slivers = this.slivers ?? [];
    } else if (this.sliver != null) {
      slivers = <Widget?>[this.sliver].cast<Widget>();
    } else {
      slivers = [];
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
            withTopMargin
                ? SliverPersistentHeader(
                    delegate: _BaseHeader(title, caption, showProfileButton,
                        showBackButton, onBackPressed, profileUrlImage),
                    pinned: false,
                  )
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 20),
                      child: _TitleView(
                        showBackButton: showBackButton,
                        title: title,
                        onBackPressed: onBackPressed,
                      ),
                    ),
                  ),
          ] +
          (slivers),
    );
  }
}

class _BaseHeader extends SliverPersistentHeaderDelegate {
  final String? title;
  final String caption;
  final bool showProfileButton;
  final String? profileUrlImage;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const _BaseHeader(this.title, this.caption, this.showProfileButton,
      this.showBackButton, this.onBackPressed, this.profileUrlImage);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(top: 20, bottom: 30, left: 24, right: 20),
      child: Stack(
        children: [
          Visibility(
              visible: showProfileButton,
              child: Positioned(
                child: ProfileButton(
                  profileImage: profileUrlImage,
                ),
                right: 0,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _TitleView(
                  showBackButton: showBackButton,
                  title: title,
                  onBackPressed: onBackPressed,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Visibility(
                visible: caption.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    caption,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _TitleView extends StatelessWidget {
  const _TitleView({
    Key? key,
    required this.showBackButton,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: showBackButton,
          child: SizedBox(
            width: 40,
            height: 40,
            child: RawMaterialButton(
                shape: CircleBorder(),
                onPressed: onBackPressed ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24, 
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.left,
            ),
          )
        ),
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String? profileImage;

  const ProfileButton({Key? key, this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Stack(
          children: [
            Visibility(
              visible: profileImage != null && profileImage!.isNotEmpty,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: profileImage ?? '',
              ),
              replacement: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
            Positioned.fill(
              child: MaterialButton(
                  shape: CircleBorder(),
                  onPressed: () => _openProfilePage(context)),
            ),
          ],
        ),
      ),
    );
  }

  _openProfilePage(BuildContext context) {
    Navigator.of(context).push(ProfilePage.route());
  }
}
