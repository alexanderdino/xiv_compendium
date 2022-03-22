import 'package:flutter/cupertino.dart';
import 'package:xiv_compendium/Page/content_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'XIV Compendium',
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoColors.white,
      ),
      home: ContentListPage(title: 'XIV Compendium'),
    );
  }
}