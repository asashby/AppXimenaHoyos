import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedImage extends StatelessWidget {
  final double radius;
  final BorderRadius? borderRadius;
  final String? imageAsset;
  final String? imageNetwork;
  final EdgeInsetsGeometry padding;
  final BoxFit fit;

  const RoundedImage(
      {Key? key,
      this.radius = 10.0,
      this.imageAsset,
      this.imageNetwork,
      this.padding = const EdgeInsets.all(2),
      this.borderRadius, this.fit = BoxFit.cover})
      : assert(imageAsset == null || imageNetwork == null,
            'Solo se debe utilizar imageAsset o imageNetwork, no ambos'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: ClipRRect(
          borderRadius: this.borderRadius ?? BorderRadius.circular(this.radius),
          child: buildImage()),
    );
  }

  Widget buildImage() {
    if (imageAsset != null) {
      return Image.asset(
        imageAsset!,
        fit: fit,
        alignment: Alignment.topCenter,
      );
    } else if (imageNetwork != null) {
      return CachedNetworkImage(
        placeholder: (ctx, url) => _PlaceholderImage(),
        imageUrl: imageNetwork!,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      );
    } else {
      return _PlaceholderImage();
    }
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.asset(
          'resources/app_logo.png',
        ),
      ),
    );
  }
}
