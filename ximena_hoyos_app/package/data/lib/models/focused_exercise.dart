import 'package:data/models/focused_exercise_item.dart';
import 'package:flutter/foundation.dart';

@immutable
class FocusedExercise {
  final int? id;
  final String? title;
  final String? slug;
  final String? subtitle;
  final String? videoUrl;
  final String? description;
  final String? desktopImageUrl;
  final String? mobileImageUrl;
  final bool? currentUserIsSubscribed;
  final List<FocusedExerciseItem> focusedExerciseItems;

  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  const FocusedExercise({
    this.id,
    this.title,
    this.slug,
    this.subtitle,
    this.videoUrl,
    this.description,
    this.desktopImageUrl,
    this.mobileImageUrl,
    this.currentUserIsSubscribed,
    this.focusedExerciseItems = const [],
  });

  factory FocusedExercise.fromJson(Map<String, dynamic> json) =>
      FocusedExercise(
        id: json['id'] as int?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        subtitle: json['subtitle'] as String?,
        videoUrl: json['video_url'] as String?,
        description: json['description'] as String?,
        desktopImageUrl: json['desktop_image_url'] as String?,
        mobileImageUrl: json['mobile_image_url'] as String?,
        currentUserIsSubscribed: json['current_user_is_subcribed'] as bool?,
        focusedExerciseItems: (json['focused_exercise_items'] as List? ?? [])
            .map((e) => FocusedExerciseItem.fromJson(e)).toList()
      );
}
