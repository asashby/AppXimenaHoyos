import 'package:data/common/provider.dart';

enum ProfileGoal { muscle, tonify, slim }

extension ProfileGoalExtension on ProfileGoal {
  String get name => this.toString().split('.').last;

  String get formattedName {
    switch (this) {
      case ProfileGoal.slim:
        return 'slim down';
      default:
        return this.name;
    }
  }
}

ProfileGoal? _userGoalFromString(String name) {
  return ProfileGoal.values.cast<ProfileGoal?>().firstWhere(
      (element) => name.toLowerCase() == element!.formattedName,
      orElse: () => null);
}

class Profile {
  final int id;
  final String? name;
  final String? surname;
  final String email;
  final Provider? origin;
  final String? urlImage;
  final bool flagGoal;
  final ProfileGoal? goal;
  final ProfileInformationAdditional additionalInformation;

  String get fullName => "${name ?? ''} ${surname ?? ''}".trim();

  Profile.fromJson(dynamic data)
      : id = data['id'],
        name = data['name'],
        surname = data['sur_name'],
        email = data['email'],
        origin = ProviderHelper.parse(data['origin']),
        urlImage = data['url_image'],
        flagGoal = data['flag_goald'] == 1,
        goal = _userGoalFromString(data['goal'] ?? ''),
        additionalInformation = ProfileInformationAdditional.fromJson(
            data['addittional_info'] ?? {});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sur_name': surname,
        'email': email,
        'origin': origin!.name,
        'url_image': urlImage,
        'flag_goald': flagGoal,
        'goal': goal?.name,
        'addittional_info': additionalInformation.toJson()
      };
}

class ProfileInformationAdditional {
  final int? age;
  final int? size;
  final int? weight;

  ProfileInformationAdditional.fromJson(dynamic data)
      : age = data['age'],
        size = data['size'],
        weight = data['weight'];

  ProfileInformationAdditional.build(int? age, int? size, int? weight)
      : age = age,
        size = size,
        weight = weight;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['age'] = age;
    data['size'] = size;
    data['weight'] = weight;

    return data;
  }
}

// ----------------------------------------

class ProfileUpdateRaw {
  final String? name;
  final String? lastName;
  final ProfileGoal? goal;
  final ProfileInformationAdditional? additional;

  ProfileUpdateRaw({this.name, this.lastName, this.goal, this.additional});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['name'] = name;
    data['last_name'] = lastName;
    data['goal'] = goal?.formattedName;
    data['addittional_info'] = additional?.toJson();

    return data;
  }
}
