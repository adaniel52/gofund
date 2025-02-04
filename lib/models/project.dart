class Project {
  final int id;
  final String name;
  final double collectedAmount;
  final double goalAmount;
  final String? imageUrl;
  final DateTime? createdAt;

  Project({
    required this.id,
    required this.name,
    this.collectedAmount = 0,
    required this.goalAmount,
    this.imageUrl,
    this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      collectedAmount: (json['collected_amount'] as num).toDouble(),
      goalAmount: (json['goal_amount'] as num).toDouble(),
      imageUrl: json['image_url'],
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
      'created_at': createdAt,
    };
  }

  bool get isFinished => collectedAmount >= goalAmount;
}
