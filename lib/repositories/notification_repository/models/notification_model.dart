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
  final int? paymentId;
  final int? totalPrice;
  final String? description;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.userId,
    this.paymentId,
    this.totalPrice,
    this.description,
    required this.notifiableId,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']; // Ambil objek data utama

    return NotificationModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? "",
      title: data?['title'] ?? "", // Pastikan mengambil dari `data`
      message: data?['message'] ?? "",
      userId: data?['user_id'],
      notifiableId: json['notifiable_id'] ?? 0,
      readAt:
          json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      description: data?['description'],
      paymentId: data?['payment_id'] != null
          ? int.tryParse(data!['payment_id'].toString())
          : null,
      totalPrice: data?['total_price'] != null
          ? int.tryParse(data!['total_price'].toString())
          : null,
    );
  }
}
