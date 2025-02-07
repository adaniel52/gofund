class Project {
  final int id;
  final String name;
  final double collectedAmount;
  final double goalAmount;
  final String? imageUrl;
  final int bankId;
  final DateTime createdAt;

  const Project({
    required this.id,
    required this.name,
    this.collectedAmount = 0,
    required this.goalAmount,
    this.imageUrl,
    required this.bankId,
    required this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      collectedAmount: (json['collected_amount'] as num).toDouble(),
      goalAmount: (json['goal_amount'] as num).toDouble(),
      imageUrl: json['image_url'],
      bankId: json['bank_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'collected_amount': collectedAmount,
      'goal_amount': goalAmount,
      'image_url': imageUrl,
      'bank_id': bankId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Project copyWith({
    int? id,
    String? name,
    double? collectedAmount,
    double? goalAmount,
    String? imageUrl,
    int? bankId,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      collectedAmount: collectedAmount ?? this.collectedAmount,
      goalAmount: goalAmount ?? this.goalAmount,
      imageUrl: imageUrl ?? this.imageUrl,
      bankId: bankId ?? this.bankId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isFinished => (collectedAmount >= goalAmount);

  double get completionRatio => (collectedAmount / goalAmount);
  double get percent {
    double percent = completionRatio * 100;
    if (percent > 100) percent = 100;
    return percent;
  }

  String get collectedAmountText => collectedAmount.toStringAsFixed(2);
  String get goalAmountText => goalAmount.toStringAsFixed(2);
  String get percentText => '${percent.toStringAsFixed(2)}%';
  String get progressText =>
      'RM $collectedAmountText / $goalAmountText ($percentText)';
}
