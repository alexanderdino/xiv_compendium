class GameContentDetail {
  final int id;
  final String icon;
  final String name;
  final String url;
  final String description;
  final int levelItem;

  const GameContentDetail({
    required this.id,
    required this.icon,
    required this.name,
    required this.url,
    required this.description,
    required this.levelItem,
  });

  factory GameContentDetail.fromJson(Map<String, dynamic> json) {
    return GameContentDetail(
        id: json['ID'],
        icon: json['Icon'],
        name: json['Name'],
        url: json['Url'],
        description: json['Description'],
        levelItem: json['LevelItem']
    );
  }
}