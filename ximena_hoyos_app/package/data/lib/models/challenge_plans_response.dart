import 'package:data/models/challenge_plan.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChallengePlansResponse {
  final List<dynamic>? plansByCourse;

  const ChallengePlansResponse({
    this.plansByCourse,
  });


  factory ChallengePlansResponse.fromJson(Map<String, List<dynamic>> json) =>
    ChallengePlansResponse(
      plansByCourse: json['plansByCourse'],
    );

  Map<String, dynamic> toJson() => {
        'plansByCourse': plansByCourse,
  };
}
