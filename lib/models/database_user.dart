class DatabaseUser {
  final String id;
  final String name;
  final double totalDonated;

  const DatabaseUser({
    required this.id,
    this.name = 'Guest',
    this.totalDonated = 0,
  });

  factory DatabaseUser.fromJson(Map<String, dynamic> json) {
    return DatabaseUser(
      id: json['id'],
      name: json['name'],
      totalDonated: json['total_donated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'total_donated': totalDonated,
    };
  }

  DatabaseUser copyWith({
    String? id,
    String? name,
    double? totalDonated,
  }) {
    return DatabaseUser(
      id: id ?? this.id,
      name: name ?? this.name,
      totalDonated: totalDonated ?? this.totalDonated,
    );
  }

  String get totalDonatedText => 'RM ${totalDonated.toStringAsFixed(2)}';
}
