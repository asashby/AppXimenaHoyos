class CurrentCourses {
  String? status;
  int? courseCount;

  CurrentCourses({this.status, this.courseCount});

  CurrentCourses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    courseCount = json['courseCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['courseCount'] = this.courseCount;
    return data;
  }
}
