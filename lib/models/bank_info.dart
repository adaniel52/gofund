class BankInfo {
  final String accountName;
  final String accountNumber;
  final String bankName;

  BankInfo({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  BankInfo copyWith({
    String? accountName,
    String? accountNumber,
    String? bankName,
  }) {
    return BankInfo(
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
    );
  }
}
