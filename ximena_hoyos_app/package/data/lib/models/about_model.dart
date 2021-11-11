enum SocialNetwork { TIKTOK, FACEBOOK, INSTAGRAM, YOUTUBE, UNKNOWN }

extension on SocialNetwork {
  String get name => this.toString().split('.').last;
}

SocialNetwork _socialNetworkFromString(String name) {
  return SocialNetwork.values.firstWhere(
      (element) => name.toUpperCase() == element.name,
      orElse: () => SocialNetwork.UNKNOWN);
}

class About {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final String content;
  final String? banner;
  final String? pageImage;
  final String? urlVideo;
  final String? mobileImage;
  final Map<SocialNetwork, String> socialNetworks;

  About.fromJson(dynamic data)
      : id = data['id'],
        title = data['title'] ?? '',
        subtitle = data['subtitle'] ?? '',
        description = data['description'] ?? '',
        content = data['content'] ?? '',
        banner = data['banner'],
        pageImage = data['page_image'],
        urlVideo = data['url_video'],
        mobileImage = data['mobile_image'],
        socialNetworks = _mapSocialNetworks(
            data['addittional_info'] ?? {}, data['url_video']);

  static Map<SocialNetwork, String> _mapSocialNetworks(
      Map<String, dynamic> data, String? urlVideo) {
    final map = data.map((key, value) {
      return MapEntry(_socialNetworkFromString(key), value.toString());
    });
    if (urlVideo != null) {
      map[SocialNetwork.YOUTUBE] = urlVideo;
    }
    return map;
  }
}
