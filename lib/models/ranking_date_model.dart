class RankingDate {
  final String id;
  final String spiderTime;
  final String rankingId;
  final String? startTime;
  final String? endTime;
  final String showDate;
  final String queryDate;
  final String value;

  RankingDate({
    required this.id,
    required this.spiderTime,
    required this.rankingId,
    this.startTime,
    this.endTime,
    required this.showDate,
    required this.queryDate,
    required this.value,
  });

  factory RankingDate.fromJson(Map<String, dynamic> json) {
    return RankingDate(
      id: json['_id'],
      spiderTime: json['spiderTime'],
      rankingId: json['rankingId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      showDate: json['showDate'],
      queryDate: json['queryDate'],
      value: json['value'],
    );
  }
} 