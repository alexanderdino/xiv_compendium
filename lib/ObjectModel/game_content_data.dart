import 'game_content.dart';
import 'page_info.dart';

class GameContentData {
  final List<GameContent> results;
  final PageInfo pagination;

  const GameContentData({
    required this.pagination,
    required this.results,
  });

  factory GameContentData.fromJson(Map<String, dynamic> json) {
    List<GameContent> contents = (json['Results'] as List).map((e) => GameContent.fromJson(e)).toList();

    return GameContentData(
        pagination: PageInfo.fromJson(json['Pagination']),
        results: contents,
    );
  }
}