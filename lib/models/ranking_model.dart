import 'platform_model.dart';

class Ranking {
  final String id;
  final String name;
  final String? description;
  final String? icon;
  final String platformId;
  final String? rules;
  final int sort;
  final int status;
  final String type;
  final String updateFrequency;
  final String updateTime;
  final String? labelsShow;
  final Platform? platform;
  final DateTime createTime;

  Ranking({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.platformId,
    this.rules,
    required this.sort,
    required this.status,
    required this.type,
    required this.updateFrequency,
    required this.updateTime,
    this.labelsShow,
    this.platform,
    required this.createTime,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      platformId: json['platformId'],
      rules: json['rules'],
      sort: json['sort'] ?? 0,
      status: json['status'] ?? 0,
      type: json['type'],
      updateFrequency: json['updateFrequency'],
      updateTime: json['updateTime'],
      labelsShow: json['labels_show'],
      platform: json['platform'] != null ? Platform.fromJson(json['platform']) : null,
      createTime: DateTime.parse(json['createTime']),
    );
  }
} 