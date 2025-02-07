class Bank {
  final int id;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String? bankImageUrl;
  final DateTime createdAt;

  const Bank({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    this.bankImageUrl,
    required this.createdAt,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      bankImageUrl: json['bank_image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
      'bank_image_url': bankImageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Bank copyWith({
    int? id,
    String? accountName,
    String? accountNumber,
    String? bankName,
    String? bankImageUrl,
    DateTime? createdAt,
  }) {
    return Bank(
      id: id ?? this.id,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      bankImageUrl: bankImageUrl ?? this.bankImageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
