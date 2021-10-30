import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BasePage extends StatelessWidget {
  final String? imageAsset;
  final String? imageNetwork;
  final List<Widget> slivers;
  final Function? onClosePressed;
  final Color? backgroundColor;

  const BasePage(
      {Key? key,
      this.imageAsset,
      this.imageNetwork,
      required this.slivers,
      this.onClosePressed,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: 450,
              child: buildBackgroundImage()),
          CustomScrollView(
            slivers: <Widget>[
                  SliverPersistentHeader(
                      delegate: _BasePageHeader(onClosePressed))
                ] +
                this.slivers,
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage() {
    return imageNetwork != null
        ? Image.network(
            imageNetwork!,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )
        : imageAsset != null
            ? Image.asset(
                imageAsset!,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              )
            : SizedBox.shrink();
  }
}

class _BasePageHeader extends SliverPersistentHeaderDelegate {
  final Function? onClosePressed;

  _BasePageHeader(this.onClosePressed);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Visibility(
        visible: onClosePressed != null,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 45,
              height: 45,
              child: RawMaterialButton(
                  shape: CircleBorder(),
                  fillColor: Colors.white,
                  onPressed: onClosePressed as void Function()?,
                  child: Icon(
                    Icons.close,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
