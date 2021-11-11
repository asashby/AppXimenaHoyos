import 'package:intl/intl.dart';

class Tip {
  final int id;
  final String title;
  final String subtitle;
  final String slug;
  final String? pageImage;
  final String? mobileImage;
  final String route;
  final String resume;
  final String content;
  final String publishedAt;

  Tip.fromJson(dynamic data)
      : id = data['id'] ?? -1,
        title = data['title'] ?? '',
        subtitle = data['subtitle'] ?? '',
        slug = data['slug'] ?? '',
        pageImage = data['page_image'],
        mobileImage = data['page_image'],
        route = data['route'] ?? '',
        resume = data['resume'] ?? '',
        content = data['content'] ?? '',
        publishedAt = data['published_at'] ?? '';

  String get publishedAtWithFormat {
    if (publishedAt.isEmpty) {
      return "";
    } else {
      final dateTime = DateTime.parse(publishedAt);
      return DateFormat('HH:mm  dd/MM/yyyy').format(dateTime);
    }
  }
}
