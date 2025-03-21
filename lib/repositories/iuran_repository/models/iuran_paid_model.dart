class IuranPaidModel {
  final int id;
  final String name;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final DateTime? paidDate;
  final int totalAmount;
  final int paidAmount;
  final String note;
  final String status;
  String get translateStatus {
    switch (status) {
      case 'unpaid':
        return 'Belum Bayar';
      case 'paid':
        return 'Lunas';
      default:
        return 'Status tidak tersedia';
    }
  }

  IuranPaidModel({
    required this.id,
    required this.name,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    this.paidDate,
    required this.totalAmount,
    required this.paidAmount,
    required this.note,
    required this.status,
  });

  factory IuranPaidModel.fromJson(Map<String, dynamic> json) {
    return IuranPaidModel(
      id: json["id"],
      name: json["name"],
      invoiceNumber: json["invoice_number"],
      invoiceDate: DateTime.parse(json["invoice_date"]),
      dueDate: DateTime.parse(json["due_date"]),
      paidDate:
          json["paid_date"] != null ? DateTime.parse(json["paid_date"]) : null,
      totalAmount: json["total_amount"],
      paidAmount: json["paid_amount"],
      note: json["note"] ?? "",
      status: json["status"],
    );
  }
}
