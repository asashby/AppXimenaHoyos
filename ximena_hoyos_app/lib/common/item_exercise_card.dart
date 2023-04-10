import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/check_widget.dart';

class ItemExerciseCard extends StatelessWidget {
  final String subtitle;
  final String title;
  final bool isCompleted;
  final bool isAvailable;
  final String? urlIcon;
  final Icon? defaultIcon;
  final Color? iconBackgroundColor;
  final VoidCallback onPressed;

  const ItemExerciseCard({
    Key? key,
    this.subtitle = "",
    this.title = "",
    this.isCompleted = false,
    this.isAvailable = false,
    this.urlIcon = null,
    this.defaultIcon = null,
    this.iconBackgroundColor = Colors.grey,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget leftIcon = SizedBox.shrink();
    if (urlIcon != null && urlIcon!.isNotEmpty) {
      leftIcon = Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          child: CachedNetworkImage(imageUrl: urlIcon!),
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    } else if(defaultIcon != null) {
      leftIcon = Container(
        width: 48,
        height: 48,
        decoration: defaultIcon!.size != 48 ? BoxDecoration(
          color: iconBackgroundColor,
          shape: BoxShape.circle,
        ) : null,
        child: defaultIcon,
      );
    }

    return MaterialButton(
      minWidth: double.infinity,
      height: 80,
      color: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          leftIcon,
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subtitle == "" ? SizedBox.shrink() : Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.grey[500]),
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.black),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckWidget(
              active: isCompleted,
              coursePaid: isAvailable ? 1 : 0,
            ),
          )
        ],
      ),
    );
  }
}