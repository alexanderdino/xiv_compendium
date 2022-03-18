class PageInfo {
  final int page;
  final int? pageNext;
  final int? pagePrev;
  final int pageTotal;
  final int results;
  final int resultsPerPage;
  final int resultsTotal;

  const PageInfo({
    required this.page,
    required this.pageNext,
    required this.pagePrev,
    required this.pageTotal,
    required this.results,
    required this.resultsPerPage,
    required this.resultsTotal,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
        page: json['Page'],
        pageNext: json['PageNext'],
        pagePrev: json['pagePrev'],
        pageTotal: json['PageTotal'],
        results: json['Results'],
        resultsPerPage: json['ResultsPerPage'],
        resultsTotal: json['ResultsTotal'],
    );
  }
}
