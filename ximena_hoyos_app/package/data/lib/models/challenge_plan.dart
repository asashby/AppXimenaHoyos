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
  String? description;
  String? price;

  PlansByCourse(
      {this.id,
      this.title,
      this.description,
      this.price});

  PlansByCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}