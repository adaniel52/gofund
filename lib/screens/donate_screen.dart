import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/widgets/custom_button.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const BankInfoCard(),
              const BankInfoCard(),
              const BankInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class BankInfoCard extends StatelessWidget {
  const BankInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card.filled(
      child: Padding(
        padding: AppSpacing.smallPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BankInfoRow(
              'Account Name',
              'Koperasi Sekolah Menengah Yayasan Terengganu Kuala Berang Berhad',
            ),
            Divider(),
            BankInfoRow('Account Number', '513032503116'),
            Divider(),
            BankInfoRow('Bank Name', 'Maybank'),
          ],
        ),
      ),
    );
  }
}

class BankInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const BankInfoRow(
    this.label,
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
          ),
        ),
        SizedBox.square(
          dimension: 20,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            iconSize: 15,
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: value),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard!'),
                ),
              );
            },
            icon: const Icon(Icons.copy),
          ),
        ),
      ],
    );
  }
}
