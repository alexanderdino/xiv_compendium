import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xiv_compendium/ObjectModel/game_content_data.dart';
import 'package:xiv_compendium/Page/content_detail_page.dart';
import 'package:xiv_compendium/Widget/content_list_item.dart';
import 'package:xiv_compendium/ObjectModel/game_content.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xiv_compendium/Widget/search_input_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:xiv_compendium/constants.dart';

class ContentListPage extends StatefulWidget {
  const ContentListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContentListPage> createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  final PagingController<int, GameContent> _pagingController = PagingController(firstPageKey: 1);

  String? _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newData = await fetchData(pageKey);
      final isLastPage = newData.pagination.pageNext == null;

      if (isLastPage) {
        _pagingController.appendLastPage(newData.results);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newData.results, nextPageKey);
      }
    } catch(error) {
      _pagingController.error = error;
    }
  }

  Future<GameContentData> fetchData(int pageKey) async {
    String url = "${baseUrl}search?indexes=item&page=$pageKey";
    if (_searchTerm != null) {
      url += "&string=$_searchTerm";
    }

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      return GameContentData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fetch failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title),
        ),
        child: Column(
          children: [
            SearchInputSliver(
              onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
            ),
            Expanded(child: _createCustomScrollView())
          ],
        )
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _createCustomScrollView()
    );
  }

  CustomScrollView _createCustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        PagedSliverList<int, GameContent>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<GameContent>(
              animateTransitions: true,
              itemBuilder: (context, item, index) =>
                  ContentListItem(
                    name: item.name,
                    iconPath: item.icon,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContentDetailPage(title: item.name, contentId: item.id,)),
                      );
                    },
                  )
          ),
        )
      ],
    );
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }
}
