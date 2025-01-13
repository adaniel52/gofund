class Project {
  final String imageUrl;
  final String productName;
  final int productAmount;
  final double currentFund;
  final double targetFund;

  Project({
    required this.imageUrl,
    required this.productName,
    required this.productAmount,
    required this.currentFund,
    required this.targetFund,
  });

  Project copyWith({
    String? imageUrl,
    String? productName,
    int? productAmount,
    double? currentFund,
    double? targetFund,
  }) {
    return Project(
      imageUrl: imageUrl ?? this.imageUrl,
      productName: productName ?? this.productName,
      productAmount: productAmount ?? this.productAmount,
      currentFund: currentFund ?? this.currentFund,
      targetFund: targetFund ?? this.targetFund,
    );
  }
}
