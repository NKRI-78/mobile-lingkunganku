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
  final String? body;
  final String? paymentType;
  final String? paymentNumber;

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
    required this.body,
    this.paymentType,
    this.paymentNumber,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']; // Ambil objek data utama

    return NotificationModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? "",
      title: data?['title'] ?? "", // Pastikan mengambil dari `data`
      message: data?['message'] ?? "",
      body: data?['body'] ?? "",
      userId: data?['user_id'],
      notifiableId: json['notifiable_id'] ?? 0,
      readAt:
          json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      description: data?['description'],
      paymentId: data?['payment_id'] != null
          ? int.tryParse(data['payment_id'].toString())
          : null,
      totalPrice: data?['total_price'] != null
          ? int.tryParse(data['total_price'].toString())
          : null,
      paymentType: data?['payment_type'],
      paymentNumber: data?['payment_number'],
    );
  }

  /// Tambahkan method copyWith
  NotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    int? userId,
    int? notifiableId,
    DateTime? readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? paymentId,
    int? totalPrice,
    String? description,
    String? body,
    String? paymentType,
    String? paymentNumber,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      notifiableId: notifiableId ?? this.notifiableId,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paymentId: paymentId ?? this.paymentId,
      totalPrice: totalPrice ?? this.totalPrice,
      description: description ?? this.description,
      body: body ?? this.body,
      paymentType: paymentType ?? this.paymentType,
      paymentNumber: paymentNumber ?? this.paymentNumber,
    );
  }
}
