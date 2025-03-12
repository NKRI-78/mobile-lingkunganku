class NotificationModel {
  final int id;
  final String type;
  final String title;
  final String message;
  final int? userId;
  final int notifiableId;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.userId,
    required this.notifiableId,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? "",
      title: json['data']?['title'] ?? "",
      message: json['data']?['message'] ?? "",
      userId: json['data']?['user_id'], // Bisa null
      notifiableId: json['notifiable_id'] ?? 0,
      readAt:
          json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
