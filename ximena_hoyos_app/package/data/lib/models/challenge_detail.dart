import 'package:flutter/foundation.dart';

@immutable
class ChallengeDetail {
  final int? id;
  final int? extId;
  final String? title;
  final String? subtitle;
  final String? slug;
  final int? days;
  final String? type;
  final String? level;
  final String? frequency;
  final String? duration;
  final String? urlImage;
  final String? banner;
  final double rating;
  final String? description;
  final String? urlVideo;
  final int? isActivated;
  final int? coursePaid;
  final dynamic fileUrl;
  final dynamic attributes;
  final dynamic deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? mobileImage;
  final int? users;
  final String? price;
  final int? unitId;

  const ChallengeDetail({
    this.extId,
    this.price,
    this.id,
    this.title,
    this.subtitle,
    this.slug,
    this.days,
    this.type,
    this.level,
    this.frequency,
    this.duration,
    this.urlImage,
    this.banner,
    required this.rating,
    this.description,
    this.urlVideo,
    this.isActivated,
    this.coursePaid,
    this.fileUrl,
    this.attributes,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.mobileImage,
    this.users,
    this.unitId,
  });

  factory ChallengeDetail.fromJson(Map<String, dynamic> json) =>
      ChallengeDetail(
          id: json['id'] as int?,
          extId: json['ext_id'] as int?,
          title: json['title'] as String?,
          subtitle: json['subtitle'] as String?,
          slug: json['slug'] as String?,
          days: json['days'] as int?,
          type: json['type'] as String?,
          level: json['level'] as String?,
          frequency: json['frequency'] as String?,
          duration: json['duration'] as String?,
          urlImage: json['url_image'] as String?,
          banner: json['banner'] as String?,
          rating: double.parse(json['rating'] ?? "0.0"),
          description: json['description'] as String?,
          urlVideo: json['url_video'] as String?,
          isActivated: json['is_activated'] as int?,
          coursePaid: json['course_paid'] as int?,
          fileUrl: json['file_url'],
          attributes: json['attributes'],
          deletedAt: json['deleted_at'],
          createdAt: json['created_at'] as String?,
          updatedAt: json['updated_at'] as String?,
          mobileImage: json['mobile_image'] as String?,
          users: json['users'] as int?,
          unitId: json['unitId'] as int?,
          price: json['prices'] as String?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'slug': slug,
        'days': days,
        'type': type,
        'level': level,
        'frequency': frequency,
        'duration': duration,
        'url_image': urlImage,
        'banner': banner,
        'rating': rating,
        'description': description,
        'url_video': urlVideo,
        'is_activated': isActivated,
        'course_paid': coursePaid,
        'file_url': fileUrl,
        'attributes': attributes,
        'deleted_at': deletedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'mobile_image': mobileImage,
        'users': users,
      };
}
