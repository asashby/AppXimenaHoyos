import 'package:flutter/foundation.dart';

@immutable
class ChallengePlan {
  List<PlansByCourse>? plansByCourse;

  ChallengePlan({this.plansByCourse});

  ChallengePlan.fromJson(Map<String, dynamic> json) {
    if (json['plansByCourse'] != null) {
      plansByCourse = <PlansByCourse>[];
      json['plansByCourse'].forEach((v) {
        plansByCourse!.add(new PlansByCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plansByCourse != null) {
      data['plansByCourse'] =
          this.plansByCourse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlansByCourse {
  int? id;
  String? title;
  List<String>? slug;
  String? description;
  int? months;
  String? price;
  List<int>? courseId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? isActivated;

  PlansByCourse(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.months,
      this.price,
      this.courseId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.isActivated});

  PlansByCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'].cast<String>();
    description = json['description'];
    months = json['months'];
    price = json['price'];
    courseId = json['course_id'].cast<int>();
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActivated = json['is_activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['months'] = this.months;
    data['price'] = this.price;
    data['course_id'] = this.courseId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_activated'] = this.isActivated;
    return data;
  }
}