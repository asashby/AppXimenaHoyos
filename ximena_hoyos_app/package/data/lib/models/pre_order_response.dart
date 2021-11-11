class PreOrder {
  final String status;
  final String message;
  final int requestId;
  final int id;
  final String processUrl;

  PreOrder.toJson(dynamic data)
      : status = data['status'] ?? '',
        message = data['message'] ?? '',
        requestId = data['requestId'] ?? 0,
        id = data['id'] ?? 0,
        processUrl = data['processUrl'] ?? '';
}
