import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/bank_info.dart';
import 'package:gofund/widgets/bank_info_card.dart';
import 'package:gofund/widgets/custom_button.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BankInfo> bankAccounts = [
      BankInfo(
        accountName:
            'Koperasi Sekolah Menengah Yayasan Terengganu Kuala Berang Berhad',
        accountNumber: '513032503116',
        bankName: 'Maybank',
      ),
      BankInfo(
        accountName:
            'Koperasi Sekolah Menengah Yayasan Terengganu Kuala Berang Berhad',
        accountNumber: '513032503116',
        bankName: 'Maybank',
      ),
      BankInfo(
        accountName:
            'Koperasi Sekolah Menengah Yayasan Terengganu Kuala Berang Berhad',
        accountNumber: '513032503116',
        bankName: 'Maybank',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.small,
            children: [
              const Text(
                'Online Payment',
                style: AppTextStyles.subtitle,
              ),
              const Text('Insert amount of money (MYR):'),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.mediumRadius,
                  ),
                ),
              ),
              CustomButton(
                text: 'Donate',
                onPressed: () {},
              ),
              const Text(
                'Powered by Stripe',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              const Divider(),
              const Text(
                'Prefer to pay manually?',
                style: AppTextStyles.subtitle,
              ),
              const Text(
                  'You can use these school\'s bank accounts information:'),
              ...bankAccounts.map(
                (e) => BankInfoCard(bankInfo: e),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
