import 'package:flutter/material.dart';

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

    final String imageUrl;
    if (iconPath.isNotEmpty) {
      imageUrl = 'https://xivapi.com/$iconPath';
    } else {
      imageUrl = 'https://xivapi.com/img-misc/chat_messengericon_dutyroulette.png';
    }

    contents.add(
        Image.network(
          imageUrl,
          height: 24,
        )
    );
    contents.add(Container(width: 8));
    contents.add(Expanded(child: Text(name)));

    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: contents,
          )
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
