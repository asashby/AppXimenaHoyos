class ChallengesDailyRoutine {
  final int id;
  final String title;
  final int day;
  final String slug;
  final String? urlIcon;
  final bool flagCompleteUnit;

  ChallengesDailyRoutine.fromJson(dynamic json)
      : id = json['id'] ?? -1,
        title = json['title'] ?? "",
        day = int.tryParse(json['day']) ?? -1,
        slug = json['slug'],
        urlIcon = json['url_icon'],
        flagCompleteUnit = json['flag_complete_unit'] == 1;
}
