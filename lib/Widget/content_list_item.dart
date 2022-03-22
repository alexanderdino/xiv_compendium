import 'package:flutter/material.dart';
import 'package:xiv_compendium/constants.dart';

class ContentListItem extends StatelessWidget {
  const ContentListItem({
    required this.name,
    required this.iconPath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String name;
  final String iconPath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (iconPath.isEmpty && name.isEmpty) {
      return const SizedBox.shrink();
    }

    List<Widget> contents = [];

    final String imageUrl = '$baseUrl$iconPath';

    contents.add(
        Image.network(
          imageUrl,
          height: 24,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const SizedBox.shrink();
          },
        )
    );
    contents.add(Container(width: 8));
    contents.add(
        Expanded(
            child: Text(name, textDirection: TextDirection.ltr,)
        )
    );

    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            textDirection: TextDirection.ltr,
            children: contents,
          )
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
