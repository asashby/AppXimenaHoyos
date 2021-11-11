class Comment {
  final String rating;
  final String title;
  final String content;

  Comment.from(dynamic data)
      : rating = data['rating'] ?? '0.00',
        title = data['title'] ?? '',
        content = data['content'] ?? '';
}
