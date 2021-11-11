class ExcerciseHeader {
  final int id;
  final String title;
  final String subtitle;
  final String level;
  final String? mobileImage;
  final String frequency;
  final String duration;
  final String maxTime;
  final String restTime;
  final String? urlImage;
  final int courseId;

  ExcerciseHeader.fromJson(dynamic data)
      : id = data['id'] ?? 0,
        title = data['title'] ?? "",
        subtitle = data['subtitle'] ?? "",
        level = data['level'] ?? "",
        mobileImage = data['mobile_image'],
        frequency = data['frequency'] ?? "",
        duration = data['duration'] ?? "",
        maxTime = data['max_time'] ?? "",
        restTime = data['time_rest'] ?? "",
        urlImage = data['url_image'],
        courseId = data['course_id'] ?? 0;
}

class Excercise {
  final int id;
  final String slug;
  final String title;
  final int unitId;
  final bool flagCompleted;
  final ExcerciseSerie serie;

  Excercise.fromJson(dynamic data)
      : id = data['id'] ?? 0,
        slug = data['slug'] ?? '',
        title = data['title'] ?? '',
        unitId = data['unit_id'] ?? 0,
        flagCompleted = data['flag_completed'] == 1,
        serie = ExcerciseSerie.fromJson(data['series_reps'] ?? {});
}

class ExcerciseSerie {
  final int series;
  final int serie;
  final int repetitions;
  final bool flagComplete;

  ExcerciseSerie._(
      this.series, this.serie, this.repetitions, this.flagComplete);

  ExcerciseSerie copyWith(
      {int? series, int? serie, int? repetitions, bool? flagComplete}) {
    return ExcerciseSerie._(series ?? this.series, serie ?? this.serie,
        repetitions ?? this.repetitions, flagComplete ?? this.flagComplete);
  }

  ExcerciseSerie.fromJson(dynamic data)
      : series = data['series'] ?? 0,
        repetitions = data['reps'] ?? 0,
        serie = data['serie'] ?? 0,
        flagComplete = data['flag_complete'] == 1;
}

class ExerciseDetail {
  final int id;
  final String title;
  final String subtitle;
  final String level;
  final String frequency;
  final String duration;
  final int maxTime;
  final String timeRest;
  final int unitId;
  final String? mobileImage;
  final String content;
  final String? urlImage;
  final String? urlVideo;
  final int idSerieRep;
  final List<ExcerciseSerie> series;

  bool get hasVideo => urlVideo != null && urlVideo!.isNotEmpty;

  ExerciseDetail._(
      this.id,
      this.title,
      this.subtitle,
      this.level,
      this.frequency,
      this.duration,
      this.maxTime,
      this.timeRest,
      this.unitId,
      this.mobileImage,
      this.content,
      this.urlImage,
      this.urlVideo,
      this.idSerieRep,
      this.series);

  ExerciseDetail.fromJson(dynamic data)
      : id = data['id'] ?? 0,
        title = data['title'] ?? '',
        subtitle = data['subtitle'] ?? '',
        level = data['level'] ?? '',
        frequency = data['frequency'] ?? '',
        duration = data['duration'] ?? '',
        maxTime = data['max_tine'] ?? 0,
        timeRest = data['time_rest'] ?? '',
        unitId = data['unit_id'] ?? 0,
        mobileImage = data['mobile_image'],
        content = data['content'] ?? '',
        urlImage = data['url_image'],
        urlVideo = data['url_video'],
        idSerieRep = data['id_serie_rep'] ?? 0,
        series = (data['series'] as List? ?? [])
            .map((e) => ExcerciseSerie.fromJson(e))
            .toList();

  ExerciseDetail copyWith(
      {int? id,
      String? title,
      String? subtitle,
      String? level,
      String? frequency,
      String? duration,
      int? maxTime,
      String? timeRest,
      int? unitId,
      String? mobileImage,
      String? content,
      String? urlImage,
      String? urlVideo,
      int? idSerieRep,
      List<ExcerciseSerie>? series}) {
    return ExerciseDetail._(
        id ?? this.id,
        title ?? this.title,
        subtitle ?? this.subtitle,
        level ?? this.level,
        frequency ?? this.frequency,
        duration ?? this.duration,
        maxTime ?? this.maxTime,
        timeRest ?? this.timeRest,
        unitId ?? this.unitId,
        mobileImage ?? this.mobileImage,
        content ?? this.content,
        urlImage ?? this.urlImage,
        urlVideo ?? this.urlVideo,
        idSerieRep ?? this.idSerieRep,
        series ?? this.series);
  }
}
