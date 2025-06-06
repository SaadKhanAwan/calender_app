class Platform {
  final String id;
  final String name;
  final String type;
  final String? description;
  final String? icon;
  final int status;
  final int sort;
  final String? hotinfo;
  final String? nameEn;
  final String? descriptionEn;
  final DateTime createTime;
  final DateTime updateTime;

  Platform({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    this.icon,
    required this.status,
    required this.sort,
    this.hotinfo,
    this.nameEn,
    this.descriptionEn,
    required this.createTime,
    required this.updateTime,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      icon: json['icon'],
      status: json['status']?.toInt() ?? 0,
      sort: json['sort']?.toInt() ?? 0,
      hotinfo: json['hotinfo'],
      nameEn: json['name_en'],
      descriptionEn: json['description_en'],
      createTime: DateTime.parse(json['createTime']),
      updateTime: DateTime.parse(json['updateTime']),
    );
  }
} 