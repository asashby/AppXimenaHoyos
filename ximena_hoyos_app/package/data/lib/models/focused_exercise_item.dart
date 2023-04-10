import 'package:flutter/foundation.dart';

@immutable
class FocusedExerciseItem {
  final int? id;
  final int? focusedExerciseId;
  final String? title;
  final String? description;
  final String? series;
  final String? repetitions;
  final String? videoUrl;
  final String? desktopImageUrl;
  final String? mobileImageUrl;

  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  const FocusedExerciseItem({
    this.id,
    this.focusedExerciseId,
    this.title,
    this.description,
    this.series,
    this.repetitions,
    this.videoUrl,
    this.desktopImageUrl,
    this.mobileImageUrl,
  });

  factory FocusedExerciseItem.fromJson(Map<String, dynamic> json) =>
      FocusedExerciseItem(
        id: json['id'] as int?,
        focusedExerciseId: json['focused_exercise_id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        series: json['series'] as String?,
        repetitions: json['repetitions'] as String?,
        videoUrl: json['video_url'] as String?,
        desktopImageUrl: json['desktop_image_url'] as String?,
        mobileImageUrl: json['mobile_image_url'] as String?,
      );
}
