import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xiv_compendium/ObjectModel/game_content_detail.dart';
import 'package:flutter/cupertino.dart';

class ContentDetailPage extends StatefulWidget  {
  final String title;
  final int contentId;

  const ContentDetailPage({Key? key, required this.title, required this.contentId}) : super(key: key);

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.contentId} ${widget.title}'),
      ),
      child: _detailBuilder(),
    );
  }

  FutureBuilder<GameContentDetail> _detailBuilder() {
    return FutureBuilder<GameContentDetail>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listContent(snapshot.data!),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  List<Widget> _listContent(GameContentDetail detail) {
    return [
      Container(
        child: Row(
          children: <Widget>[
            Image.network('https://xivapi.com/'+detail.icon, width: 48,),
            Container(width: 8),
            Expanded(
                child: Column(
                  children: [
                    Text(detail.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("Item Level ${detail.levelItem}"),
                    Container(height: 4),
                    Text(detail.description, textAlign: TextAlign.justify,),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      )
    ];
  }


  Future<GameContentDetail> fetchData() async {
    final itemId = widget.contentId;
    final response = await http.get(Uri.parse('https://xivapi.com/item/$itemId'));

    if(response.statusCode == 200) {
      return GameContentDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fetch failed');
    }
  }
}