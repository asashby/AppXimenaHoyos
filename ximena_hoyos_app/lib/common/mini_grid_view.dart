import 'package:flutter/widgets.dart';

class MiniGridView extends StatelessWidget {
  final List<Widget> children;
  final TextDirection textDirection;

  const MiniGridView({
    Key? key,
    required this.children,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return SizedBox.shrink();
    }

    if (children.length > 4) {
      print('Advertencia: Este componente no pinteara mas de 4 items');
    }

    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: this.textDirection,
        children: [
          Expanded(
            child: children[0],
          ),
          children.length > 1
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: children[1],
                      ),
                      children.length > 2
                          ? Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: children[2],
                                  ),
                                  children.length > 3
                                      ? Expanded(child: children[3])
                                      : SizedBox.shrink(),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
