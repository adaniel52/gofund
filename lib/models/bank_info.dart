class BankInfo {
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String bankIconUrl;

  BankInfo({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankIconUrl,
  });

  BankInfo copyWith({
    String? accountName,
    String? accountNumber,
    String? bankName,
    String? bankIconUrl,
  }) {
    return BankInfo(
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      bankIconUrl: bankIconUrl ?? this.bankIconUrl,
    );
  }
}
