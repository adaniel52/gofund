class Donation {
  final String id;
  final String userId;
  final int projectId;
  final double amount;
  final DateTime? createdAt;

  const Donation({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.amount,
    this.createdAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      userId: json['user_id'],
      projectId: json['project_id'],
      amount: json['amount'] as double,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'project_id': projectId,
      'amount': amount,
      'created_at': createdAt,
    };
  }

  Donation copyWith({
    String? id,
    String? userId,
    int? projectId,
    double? amount,
    DateTime? createdAt,
  }) {
    return Donation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
