class ShortcutModel {
  final int? id;
  final String title;
  final String type; // 'url', 'ssh', 'cmd', 'app'
  final String value; // e.g. 'https://...', 'user@ip', 'docker ps'
  final String? iconData; 

  ShortcutModel({
    this.id,
    required this.title,
    required this.type,
    required this.value,
    this.iconData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'value': value,
      'iconData': iconData,
    };
  }

  factory ShortcutModel.fromMap(Map<String, dynamic> map) {
    return ShortcutModel(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      value: map['value'],
      iconData: map['iconData'],
    );
  }
}
