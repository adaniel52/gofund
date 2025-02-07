class DatabaseUser {
  final String id;
  final double totalDonated;

  const DatabaseUser({
    required this.id,
    required this.totalDonated,
  });

  factory DatabaseUser.fromJson(Map<String, dynamic> json) {
    return DatabaseUser(
      id: json['id'],
      totalDonated: json['total_donated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_donated': totalDonated,
    };
  }

  DatabaseUser copyWith({String? id, double? totalDonated}) {
    return DatabaseUser(
      id: id ?? this.id,
      totalDonated: totalDonated ?? this.totalDonated,
    );
  }
}
