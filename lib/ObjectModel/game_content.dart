class GameContent {
  final int id;
  final String icon;
  final String name;
  final String url;

  const GameContent({
    required this.id,
    required this.icon,
    required this.name,
    required this.url
  });

  factory GameContent.fromJson(Map<String, dynamic> json) {
    return GameContent(
      id: json['ID'],
      icon: json['Icon'],
      name: json['Name'],
      url: json['Url']
    );
  }
}